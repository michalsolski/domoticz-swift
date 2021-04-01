//
//  AuthenticationDataStorage.swift
//  
//
//  Created by Michał Solski on 01/04/2021.
//

import Foundation
import Combine

//sourcery: AutoMockable
protocol AuthenticationDataStorage {
    var authenticationData: AuthenticationData? { get set }
    var authenticationDataPubliser: Published<AuthenticationData?>.Publisher { get }
}

class AuthenticationDataStorageImpl: AuthenticationDataStorage {
    
    var keychainStorage: KeychainStorage
    static var shared: AuthenticationDataStorageImpl = AuthenticationDataStorageImpl()
    
    @Published fileprivate var publishedAuthenticationData: AuthenticationData?
    
    private init(keychainStorage: KeychainStorage = KeychainStorageImpl()) {
        self.keychainStorage = keychainStorage
        self.publishedAuthenticationData = self.authenticationData
    }
    
    var authenticationData: AuthenticationData? {
        get {
            if let login = keychainStorage.objectForKey(StorageConsts.login),
               let password = keychainStorage.objectForKey(StorageConsts.password),
               let server = keychainStorage.objectForKey(StorageConsts.server) {
                return AuthenticationData(server: server, login: login, password: password)
            }
            return nil
        }
        set {
            if newValue != nil {
                keychainStorage.setObject(StorageConsts.login, value: newValue!.login)
                keychainStorage.setObject(StorageConsts.password, value: newValue!.password)
                keychainStorage.setObject(StorageConsts.server, value: newValue!.server)
            } else {
                keychainStorage.removeObject(StorageConsts.login)
                keychainStorage.removeObject(StorageConsts.password)
                keychainStorage.removeObject(StorageConsts.server)
            }
            publishedAuthenticationData = newValue
        }
    }
}

//publisher protocol confimation
extension AuthenticationDataStorageImpl {
    var authenticationDataPubliser: Published<AuthenticationData?>.Publisher { $publishedAuthenticationData }
}

private struct StorageConsts {
    static let login = "login"
    static let password = "password"
    static let server = "server"
}
