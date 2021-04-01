//
//  AuthenticationData+sample.swift
//  
//
//  Created by Michał Solski on 03/04/2021.
//

import Foundation
@testable import DomoticzSwift

extension AuthenticationData {
    static func sample() -> AuthenticationData {
        return AuthenticationData(server: "http://192.168.13:8082", login: "john.smith", password: "p@ssw0rd")
    }
}
