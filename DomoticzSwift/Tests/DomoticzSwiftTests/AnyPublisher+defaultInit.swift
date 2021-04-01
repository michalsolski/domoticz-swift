//
//  AnyPublisher+defaultInit.swift
//  
//
//  Created by Michał Solski on 03/04/2021.
//

import Foundation
import Combine

extension AnyPublisher {
    init() {
        self.init(Empty<Output, Failure>())
    }
}
