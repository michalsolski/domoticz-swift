//
//  LoginViewModelSpec.swift
//  
//
//  Created by Michał Solski on 05/04/2021.
//

import Foundation
import Quick
import Nimble
import Combine
@testable import DomoticzSwift

final class LoginViewModelSpec: QuickSpec {
    
    override func spec() {
        
        describe("UserStateViewModelSpec") {
            
            var loginInteractorMock: LoginInteractorMock!
            var sut: LoginViewModel!
            
            beforeEach {
                loginInteractorMock = LoginInteractorMock()
                sut = LoginViewModel(loginInteractor: loginInteractorMock)
            }
            
            afterEach {
                sut = nil
            }
            
            it("login should call login interactor with correct values") {
                sut.login(host: "https://lorem.ispum", user: "root", password: "pa@@ssword")
                
                expect(loginInteractorMock.login_called).to(beTrue())
                expect(loginInteractorMock.login_params?.server).to(equal("https://lorem.ispum"))
                expect(loginInteractorMock.login_params?.username).to(equal("root"))
                expect(loginInteractorMock.login_params?.password).to(equal("pa@@ssword"))
            }
            
            it("should indicate loading state") {
                loginInteractorMock.login_returnValue = Empty<Void, Error>(completeImmediately: false).eraseToAnyPublisher()
                
                sut.login(host: "", user: "", password: "")
                
                expect(sut.loading).to(beTrue())
            }
            
            it("should indicate finish loading state") {
                loginInteractorMock.login_returnValue = Empty<Void, Error>(completeImmediately: true).eraseToAnyPublisher()
                
                sut.login(host: "", user: "", password: "")
                
                expect(sut.loading).to(beFalse())
            }
            
            it("should update error value") {
                loginInteractorMock.login_returnValue = Fail<Void, Error>(error: DomoticzMessageError(reason: "error message value"))
                    .eraseToAnyPublisher()
                
                sut.login(host: "", user: "", password: "")
                
                expect(sut.errorMsg?.message).to(equal("error message value"))
            }
        }
    }
}
