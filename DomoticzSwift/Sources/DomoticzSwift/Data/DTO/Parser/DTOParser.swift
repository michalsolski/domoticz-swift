//
//  DTOParser.swift
//  
//
//  Created by Michał Solski on 01/04/2021.
//

import Foundation

protocol DTOParser {
    func parse<T: DomoticzDTO>(_ type: T.Type, from data: Data) throws -> T
}

class DTOParserImpl: DTOParser {
    func parse<T: DomoticzDTO>(_ type: T.Type, from data: Data) throws -> T {
        return try JSONDecoder().decode(type, from: data)
    }
}
