//
//  ErrorMessageFactory.swift
//  
//
//  Created by Michał Solski on 03/04/2021.
//

import Foundation

class ErrorMessageFactory {
    static func messageFor(error: Error) -> ErrorMessage {
        if let dError = error as? DomoticzError {
            return dError.errorMessage()
        }
        return ErrorMessage(message: error.localizedDescription,
                            additionalInfo: (error as NSError).userInfo.description)
    }
}
