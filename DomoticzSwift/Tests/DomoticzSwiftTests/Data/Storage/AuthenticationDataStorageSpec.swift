//
//  AuthenticationDataStorageSpec.swift
//  
//
//  Created by Michał Solski on 05/04/2021.
//

import Foundation
import Quick
import Nimble
@testable import DomoticzSwift

final class AuthenticationDataStorageSpec: QuickSpec {
    
    override func spec() {
        describe("AuthenticationDataStorageSpec") {
            var keychainMock: KeychainStorageMock!
            var sut: AuthenticationDataStorageImpl!
            
            beforeEach {
                keychainMock = KeychainStorageMock()
                sut = AuthenticationDataStorageImpl.shared
                sut.keychainStorage = keychainMock
            }
            
            it("should save data in keychain storage") {
                sut.authenticationData = .sample()
                
                expect(keychainMock.data["login"]).to(equal("john.smith"))
                expect(keychainMock.data["password"]).to(equal("p@ssw0rd"))
                expect(keychainMock.data["server"]).to(equal("http://192.168.13:8082"))
            }
            
            it("should load data from keychain Storage") {
                keychainMock.data["login"] = "test.login"
                keychainMock.data["password"] = "test.pass"
                keychainMock.data["server"] = "http://lorem.ipsum"
                
                let authData = sut.authenticationData
                
                expect(authData?.login).to(equal("test.login"))
                expect(authData?.password).to(equal("test.pass"))
                expect(authData?.server).to(equal("http://lorem.ipsum"))
            }
            
            it("should publish new data") {
                var receivedValue: AuthenticationData?
                let sub = sut.authenticationDataPubliser.sink { (newValue) in
                    receivedValue = newValue
                }
                
                sut.authenticationData = .sample()
                
                expect(receivedValue?.login).to(equal("john.smith"))
                expect(receivedValue?.password).to(equal("p@ssw0rd"))
                expect(receivedValue?.server).to(equal("http://192.168.13:8082"))
                sub.cancel()
            }
            
            it("should publish data removed") {
                var receivedValue: AuthenticationData?
                let sub = sut.authenticationDataPubliser.sink { (newValue) in
                    receivedValue = newValue
                }
                sut.authenticationData = .sample()
                assert(receivedValue != nil)
                
                sut.authenticationData = nil
                
                expect(receivedValue).to(beNil())
                sub.cancel()
            }
        }
    }
}
