//
//  KeychainStorage.swift
//  
//
//  Created by Michał Solski on 01/04/2021.
//

import Foundation
import KeychainSwift

protocol KeychainStorage {
    func setObject(_ key: String, value: String)
    func objectForKey(_ key: String) -> String?
    func removeObject(_ key: String)
}

class KeychainStorageImpl: KeychainSwift, KeychainStorage {
    
    override init() {
        super.init(keyPrefix: "DomoticzSwift")
        self.synchronizable = false
    }

    func setObject(_ key: String, value: String) {
        super.set(value, forKey: key, withAccess: .accessibleAfterFirstUnlockThisDeviceOnly)
    }
    
    func objectForKey(_ key: String) -> String? {
        return super.get(key)
    }
    
    func removeObject(_ key: String) {
        super.delete(key)
    }
}
