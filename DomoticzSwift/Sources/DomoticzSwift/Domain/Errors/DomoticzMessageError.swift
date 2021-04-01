//
//  DomoticzMessageError.swift
//  
//
//  Created by Michał Solski on 03/04/2021.
//

import Foundation

class DomoticzMessageError: DomoticzError {
    
    private let message: ErrorMessage
    
    init(reason: String, additionalInfo: String? = nil) {
        self.message = ErrorMessage(message: reason, additionalInfo: additionalInfo)
    }
    
    func errorMessage() -> ErrorMessage {
        message
    }
}
