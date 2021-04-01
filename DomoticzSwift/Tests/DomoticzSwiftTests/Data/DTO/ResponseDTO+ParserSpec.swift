//
//  ResponseDTO+ParserSpec.swift.swift
//  
//
//  Created by Michał Solski on 05/04/2021.
//

import Foundation
import Quick
import Nimble
@testable import DomoticzSwift

final class ResponseDTOParserSpec: QuickSpec {
    
    override func spec() {
        describe("ResponseDTOParserSpec") {
            
            it("should parser ResponseDTO") {
                let data = DTODataProvider.load(fileName: "ResponseDTO.json")
                
                let response = try! DTOParserImpl().parse(ResponseDTO.self, from: data)
                
                expect(response.status).to(equal("OK"))
            }
            
        }
    }
}
