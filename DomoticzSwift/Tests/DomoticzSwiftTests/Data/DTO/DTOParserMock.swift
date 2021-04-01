//
//  DTOParserMock.swift
//  
//
//  Created by Michał Solski on 05/04/2021.
//

import Foundation
@testable import DomoticzSwift

final class DTOParserMock: DTOParser {
    
    var parse_called = false
    var parse_parms_data: Data?
    var parse_return_value: Any?
    
    func parse<T: DomoticzDTO>(_ type: T.Type, from data: Data) throws -> T {
        parse_called = true
        parse_parms_data = data
        return parse_return_value as! T
    }
}
