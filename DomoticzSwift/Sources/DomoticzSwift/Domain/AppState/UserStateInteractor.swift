//
//  UserStateInteractor.swift
//  
//
//  Created by Michał Solski on 01/04/2021.
//

import Foundation
import Combine

//sourcery: AutoMockable
protocol UserStateInteractor {
    var isUsserLoggedPublisher: Published<Bool>.Publisher { get }
    func logout()
}

class UserStateInteractorImpl: UserStateInteractor {
    
    @Published var isUsserLogged: Bool = false
    private var authenticationDataStorage: AuthenticationDataStorage
    
    init(authenticationDataStorage: AuthenticationDataStorage = AuthenticationDataStorageImpl.shared) {
        self.authenticationDataStorage = authenticationDataStorage
        authenticationDataStorage.authenticationDataPubliser.map({ $0 != nil }).assign(to: &$isUsserLogged)
    }
    
    func logout() {
        self.authenticationDataStorage.authenticationData = nil
    }
}

//publisher protocol confimation
extension UserStateInteractorImpl {
    var isUsserLoggedPublisher: Published<Bool>.Publisher { $isUsserLogged }
}
