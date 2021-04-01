//
//  UserStateViewModelSpec.swift
//  
//
//  Created by Michał Solski on 05/04/2021.
//

import Foundation
import Quick
import Nimble
@testable import DomoticzSwift

final class UserStateViewModelSpec: QuickSpec {
    
    override func spec() {
        
        describe("UserStateViewModelSpec") {
            
            var userStateInteractorMock: UserStateInteractorMock!
            var sut: UserStateViewModel!

            
            beforeEach {
                userStateInteractorMock = UserStateInteractorMock()
                sut = UserStateViewModel(userStateInteractor: userStateInteractorMock)
            }
            
            it("should publish logged status from user state interactor") {
                var receivedValue: Bool?
                let sub = sut.$userLogged.sink { (value) in
                    receivedValue = value
                }
                
                userStateInteractorMock._isUsserLoggedPublisher = true
                
                expect(receivedValue).to(beTrue())
                sub.cancel()
            }
            
            it("should publish unlogged status from user state interactor") {
                var receivedValue: Bool?
                let sub = sut.$userLogged.sink { (value) in
                    receivedValue = value
                }
                
                userStateInteractorMock._isUsserLoggedPublisher = false
                
                expect(receivedValue).to(beFalse())
                sub.cancel()
            }
        }
    }
}
