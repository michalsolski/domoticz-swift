//
//  DomoticzError.swift
//  
//
//  Created by Michał Solski on 01/04/2021.
//

import Foundation

protocol DomoticzError: Error {
    func errorMessage() -> ErrorMessage
}
