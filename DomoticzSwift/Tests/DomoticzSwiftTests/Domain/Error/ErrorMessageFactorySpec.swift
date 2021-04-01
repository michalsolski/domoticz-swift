//
//  ErrorMessageFactorySpec.swift
//  
//
//  Created by Michał Solski on 05/04/2021.
//

import Foundation
import Quick
import Nimble
@testable import DomoticzSwift

final class ErrorMessageFactorySpec: QuickSpec {
    override func spec() {
        describe("ErrorMessageFactorySpec") {
            
            it("should return message from DomoticzError") {
                let message = ErrorMessageFactory.messageFor(error: SampleDomoticzError())
                
                expect(message.message).to(equal("SampleDomoticzMessage"))
                expect(message.additionalInfo).to(equal("SampleDomoticzExplenation"))
            }
            
            it("should return message from NSError") {
                let error = SampleNSError(domain: "ErrorDomain", code: 0, userInfo: ["info": "Error details"])
                
                let message = ErrorMessageFactory.messageFor(error: error)
                
                expect(message.message).to(equal("SampleLocalizedDescription"))
                expect(message.additionalInfo).to(equal("[\"info\": \"Error details\"]"))
            }
        }
    }
}

class SampleDomoticzError: DomoticzError {
    func errorMessage() -> ErrorMessage {
        ErrorMessage(message: "SampleDomoticzMessage", additionalInfo: "SampleDomoticzExplenation")
    }
}

class SampleNSError: NSError {
    override var localizedDescription: String {
        return "SampleLocalizedDescription"
    }
    
}
