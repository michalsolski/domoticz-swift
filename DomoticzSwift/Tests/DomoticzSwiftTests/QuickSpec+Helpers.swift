//
//  QuickSpec+Helpers.swift
//  
//
//  Created by Michał Solski on 05/04/2021.
//

import Foundation
import Quick

extension QuickSpec {
    
    func waitForMainThreadResponse() {
        let expected = expectation(description: "waitForMainThreadResponse")
        DispatchQueue.main.async {
            expected.fulfill()
        }
        waitForExpectations(timeout: 0.3, handler: nil)
    }
}
