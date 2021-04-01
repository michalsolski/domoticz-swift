//
//  LoginInteractor.swift
//  
//
//  Created by Michał Solski on 01/04/2021.
//

import Foundation
import Combine

//sourcery: AutoMockable
protocol LoginInteractor {
    func login(server: String, username: String, password: String) -> AnyPublisher<Void, Error>
}

class LoginInteractorImpl: LoginInteractor {
    
    private let domoticzRepository: DomoticzRepository
    private var authenticationDataStorage: AuthenticationDataStorage
    
    init(domoticzRepository: DomoticzRepository = DomoticzRepositoryImpl(),
         authenticationDataStorage: AuthenticationDataStorage = AuthenticationDataStorageImpl.shared) {
        self.domoticzRepository = domoticzRepository
        self.authenticationDataStorage = authenticationDataStorage
    }
    
    func login(server: String, username: String, password: String) -> AnyPublisher<Void, Error> {
        //We call the devices list to validate login data.
        guard let baseUrl = URL(string: server), server.starts(with: "http") else {
            return Fail<Void, Error>(error: DomoticzMessageError(reason: "login_server_url_error_msg".localized,
                                                additionalInfo: "login_server_url_error_info".localized))
                                                .eraseToAnyPublisher()
        }
        
        let url = baseUrl.appendingPathComponent(DomoticzServerConsts.apiPath)
        
        let loginData = "\(username):\(password)".data(using: .utf8)
        let authHeaderValue = "Basic \(loginData?.base64EncodedString() ?? "")"
        
        return domoticzRepository.get(url: url, params: DomoticzServerConsts.Params.devices,
                                      headers: [DomoticzServerConsts.Headers.authHeaderKey: authHeaderValue],
                                      type: ResponseDTO.self)
            .receive(on: DispatchQueue.main)
            .tryMap { [unowned self] (response) -> Void in
                if response.status != DomoticzServerConsts.Responses.statusOk {
                    throw DomoticzMessageError(reason: "login_server_response_error".localized,
                                               additionalInfo: "status: \(response.status)")
                } else {
                    self.authenticationDataStorage.authenticationData = AuthenticationData(server: server,
                                                                                           login: username,
                                                                                           password: password)
                }
            }.eraseToAnyPublisher()
    }
}
