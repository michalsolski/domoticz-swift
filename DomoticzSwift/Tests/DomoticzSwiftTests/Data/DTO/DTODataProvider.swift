//
//  DTODataProvider.swift
//  
//
//  Created by Michał Solski on 05/04/2021.
//

import Foundation

final class DTODataProvider {
    static func load(fileName: String) -> Data {
        let path = Bundle.module.path(forResource: fileName, ofType: nil)
        let data = try? Data(contentsOf: URL(fileURLWithPath: path!))
        return data!
    }
}
