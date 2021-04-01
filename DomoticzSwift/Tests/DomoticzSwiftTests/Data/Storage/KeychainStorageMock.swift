//
//  KeychainStorageMock.swift
//  
//
//  Created by Michał Solski on 05/04/2021.
//

import Foundation
@testable import DomoticzSwift

class KeychainStorageMock: KeychainStorage {
    var data: [String: String] = [:]
    
    func setObject(_ key: String, value: String) {
        data[key] = value
    }
    
    func objectForKey(_ key: String) -> String? {
        return data[key]
    }
    
    func removeObject(_ key: String) {
        data.removeValue(forKey: key)
    }
}
