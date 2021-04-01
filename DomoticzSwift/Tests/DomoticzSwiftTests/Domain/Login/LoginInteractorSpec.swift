//
//  LoginInteractorSpec.swift
//  
//
//  Created by Michał Solski on 05/04/2021.
//

import Foundation
import Quick
import Nimble
@testable import DomoticzSwift
import Combine

final class LoginInteractorSpec: QuickSpec {
    override func spec() {
        describe("LoginInteractorSpec") {
            
            var authenticationStorageMock: AuthenticationDataStorageMock!
            var domoticzRepository: DomoticzRepositoryMock<ResponseDTO>!
            var sut: LoginInteractorImpl!
            
            beforeEach {
                domoticzRepository = DomoticzRepositoryMock<ResponseDTO>()
                authenticationStorageMock = AuthenticationDataStorageMock()
                sut = LoginInteractorImpl(domoticzRepository: domoticzRepository, authenticationDataStorage: authenticationStorageMock)
            }
            
            it("should call correct url and params in repository") {
                let sub = sut.login(server: "http://10.10.10.10:8080", username: "userName", password: "Password")
                    .sink(receiveCompletion: { (result) in
                    switch result {
                    case .finished:
                        break
                    case .failure(_):
                        break
                    }
                }, receiveValue: {})
                self.waitForMainThreadResponse()
                
                expect(domoticzRepository.get_called).to(beTrue())
                expect(domoticzRepository.get_call_params?.headers).to(equal(["Authorization": "Basic dXNlck5hbWU6UGFzc3dvcmQ="]))
                expect(domoticzRepository.get_call_params?.params).to(equal(["type": "devices"]))
                expect(domoticzRepository.get_call_params?.url.absoluteString).to(equal("http://10.10.10.10:8080/json.htm"))
                
                sub.cancel()
            }
            
            it("should return error for incorrect host address") {
                var failError: Error?
                var success = false
                
                let sub = sut.login(server: "htp://10.10.10.10:8080", username: "", password: "")
                    .sink(receiveCompletion: { (result) in
                    switch result {
                    case .finished:
                        success = true
                    case .failure(let error):
                        failError = error
                    }
                }, receiveValue: {})
                self.waitForMainThreadResponse()
                
                expect(success).to(beFalse())
                expect(failError).toNot(beNil())
                expect((failError as? DomoticzError)?.errorMessage().message).to(equal("login_server_url_error_msg".localized))
                
                sub.cancel()
            }
            
            it("should return error for unexpected domoticz response status") {
                domoticzRepository.get_return_value = Just<ResponseDTO>(ResponseDTO(status: "ERROR"))
                    .setFailureType(to: Error.self).eraseToAnyPublisher()
                var failError: Error?
                var success = false
                
                let sub = sut.login(server: "http://10.10.10.10:8080", username: "userName", password: "Password")
                    .sink(receiveCompletion: { (result) in
                    switch result {
                    case .finished:
                        success = true
                    case .failure(let error):
                        failError = error
                    }
                }, receiveValue: {})
                self.waitForMainThreadResponse()
                
                expect(success).to(beFalse())
                expect(failError).toNot(beNil())
                expect((failError as? DomoticzError)?.errorMessage().message).to(equal("login_server_response_error".localized))
                
                sub.cancel()
            }
            
            it("should save data in authentication storage") {
                domoticzRepository.get_return_value = Just<ResponseDTO>(ResponseDTO(status: "OK"))
                    .setFailureType(to: Error.self).eraseToAnyPublisher()
                var failError: Error?
                var success = false
                
                let sub = sut.login(server: "http://10.10.10.10:8080", username: "userName", password: "Password")
                    .sink(receiveCompletion: { (result) in
                    switch result {
                    case .finished:
                        success = true
                    case .failure(let error):
                        failError = error
                    }
                }, receiveValue: {})
                self.waitForMainThreadResponse()
                
                expect(success).to(beTrue())
                expect(failError).to(beNil())
                expect(authenticationStorageMock.authenticationData?.login).to(equal("userName"))
                expect(authenticationStorageMock.authenticationData?.server).to(equal("http://10.10.10.10:8080"))
                expect(authenticationStorageMock.authenticationData?.password).to(equal("Password"))
                
                sub.cancel()
            }
        }
    }
}
