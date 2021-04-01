//
//  UserStateViewModel.swift
//  
//
//  Created by Michał Solski on 01/04/2021.
//

import Foundation
import Combine

public class UserStateViewModel: ObservableObject {
    @Published public var userLogged = false
    
    private let userStateInteractor: UserStateInteractor
    
    init(userStateInteractor: UserStateInteractor) {
        self.userStateInteractor = userStateInteractor
        userStateInteractor.isUsserLoggedPublisher.assign(to: &$userLogged)
    }
    
    public convenience init() {
        self.init(userStateInteractor: UserStateInteractorImpl())
    }
}
