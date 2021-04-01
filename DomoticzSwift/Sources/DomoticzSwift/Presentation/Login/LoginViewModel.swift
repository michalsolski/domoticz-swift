//
//  LoginViewModel.swift
//  DomoticzMac
//
//  Created by Michał Solski on 31/03/2021.
//

import Foundation
import Combine

public class LoginViewModel: ObservableObject {
    
    @Published public var loading = true
    @Published public var errorMsg: ErrorMessage?
    
    public convenience init() {
        self.init(loginInteractor: LoginInteractorImpl())
    }
    
    private let loginInteractor: LoginInteractor
    private var disposables = Set<AnyCancellable>()
    
    init(loginInteractor: LoginInteractor) {
        self.loginInteractor = loginInteractor
    }
    
    deinit {
        disposables.forEach({ $0.cancel() })
    }
    
    public func login(host: String, user: String, password: String) {
        loading = true
        loginInteractor.login(server: host, username: user, password: password)
            .sink(receiveCompletion: { [unowned self] (result) in
                self.loading = false
                switch result {
                case .finished:
                    break
                case .failure(let error):
                    self.errorMsg = ErrorMessageFactory.messageFor(error: error)
                }
            }, receiveValue: {})
            .store(in: &disposables)
    }
}
