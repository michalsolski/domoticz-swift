//
//  DomoticzRepositoryMock.swift
//  
//
//  Created by Michał Solski on 05/04/2021.
//

import Foundation
@testable import DomoticzSwift
import Combine

final class DomoticzRepositoryMock<Output: DomoticzDTO>: DomoticzRepository {
    
    var get_called = false
    var get_call_params: (url: URL, params: HttpParams, headers: HttpHeaders)?
    var get_return_value: AnyPublisher<Output, Error> = Empty<Output, Error>().eraseToAnyPublisher()
    
    func get<T>(url: URL, params: HttpParams, headers: HttpHeaders, type: T.Type) -> AnyPublisher<T, Error> where T : DomoticzDTO {
        get_called = true
        get_call_params = (url: url, params: params, headers: headers)
        return get_return_value as! (AnyPublisher<T, Error>)
    }
}
