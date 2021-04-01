//
//  DomoticzRepository.swift
//  
//
//  Created by Michał Solski on 01/04/2021.
//

import Foundation
import Combine

protocol DomoticzRepository {
    func get<T: DomoticzDTO>(url: URL, params: HttpParams, headers: HttpHeaders, type: T.Type) -> AnyPublisher<T, Error>
}

class DomoticzRepositoryImpl: DomoticzRepository {
    
    let parser: DTOParser
    let httpClient: HttpClient
    
    init(parser: DTOParser = DTOParserImpl(),
         httpClient: HttpClient = HttpClientImpl()) {
        self.parser = parser
        self.httpClient = httpClient
    }
    
    func get<T: DomoticzDTO>(url: URL, params: HttpParams,
                             headers: HttpHeaders, type: T.Type) -> AnyPublisher<T, Error> {
        let request = HttpRequest(url: url, params: params, headers: headers, method: .get)
        return httpClient.call(request: request)
            .tryMap { [unowned self] (response) -> T in
                try self.parser.parse(type, from: response.data)
            }
            .eraseToAnyPublisher()
    }
}
