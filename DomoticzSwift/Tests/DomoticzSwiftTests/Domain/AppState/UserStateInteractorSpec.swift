//
//  UserStateInteractorSpec.swift
//  
//
//  Created by Michał Solski on 03/04/2021.
//

import Foundation
import Quick
import Nimble
@testable import DomoticzSwift

final class UserStateInteractorSpec: QuickSpec {

    override func spec() {
        describe("UserStateInteractorSpec") {
            
            var authenticationDataStorageMock: AuthenticationDataStorageMock!
            var sut: UserStateInteractorImpl!
            
            beforeEach {
                authenticationDataStorageMock = AuthenticationDataStorageMock()
                sut = UserStateInteractorImpl(authenticationDataStorage: authenticationDataStorageMock)
            }
            
            afterEach {
                authenticationDataStorageMock = nil
                sut = nil
            }
            
            it("isUsserLogged should publish true if data exist in auth. storage") {
                var isLogged: Bool?
                
                let sub = sut.isUsserLoggedPublisher.sink { (isLoggedValue) in
                    isLogged = isLoggedValue
                }
                
                authenticationDataStorageMock._authenticationDataPubliser = .sample()
                
                expect(isLogged).to(beTrue())
                
                sub.cancel()
            }
            
            it("isUsserLogged should publish false if data don't exist in auth. storage") {
                var isLogged: Bool?
                authenticationDataStorageMock._authenticationDataPubliser = .sample()
                
                let sub = sut.isUsserLoggedPublisher.sink { (isLoggedValue) in
                    isLogged = isLoggedValue
                }
                
                authenticationDataStorageMock._authenticationDataPubliser = nil
                
                expect(isLogged).to(beFalse())
                
                sub.cancel()
            }
            
            it("logout should clean data in authentication data storage") {
                authenticationDataStorageMock.authenticationData = .sample()
                assert(authenticationDataStorageMock.authenticationData != nil)
                
                sut.logout()
                
                expect(authenticationDataStorageMock.authenticationData).to(beNil())
            }
        }
    }
}
