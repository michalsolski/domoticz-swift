//
//  DomoticzRepositorySpec.swift
//  
//
//  Created by Michał Solski on 05/04/2021.
//

import Foundation
import Quick
import Nimble
@testable import DomoticzSwift
import Combine

final class DomoticzRepositorySpec: QuickSpec {
    
    override func spec() {
        describe("DomoticzRepositorySpec") {
            
            var httpClientMock: HttpClientMock!
            var parserMock: DTOParserMock!
            var sut: DomoticzRepositoryImpl!
            
            beforeEach {
                httpClientMock = HttpClientMock()
                parserMock = DTOParserMock()
                
                sut = DomoticzRepositoryImpl(parser: parserMock, httpClient: httpClientMock)
            }
            
            it("get should call http client with correct arguments") {
                _ = sut.get(url: .sample(),
                        params: ["paramKey": "paramValue"],
                        headers: ["headerKey": "headerValue"], type: ResponseDTO.self)
                
                expect(httpClientMock.call_called).to(beTrue())
                expect(httpClientMock.call_params_Request?.method).to(equal(.get))
                expect(httpClientMock.call_params_Request?.url.absoluteString).to(equal("https://lorem.ipsum"))
                expect(httpClientMock.call_params_Request?.headers["headerKey"]).to(equal("headerValue"))
                expect(httpClientMock.call_params_Request?.params["paramKey"]).to(equal("paramValue"))
            }
            
            it("should publish error from http client") {
                var resultError: Error?
                httpClientMock.call_returnValue = Fail<HttpResponse, Error>(error: DomoticzMessageError(reason: "lorem ipsum")).eraseToAnyPublisher()
                
                let sub = sut.get(url: .sample(), params: [:], headers: [:], type: ResponseDTO.self)
                    .sink { (result) in
                        switch result {
                        case .failure(let error):
                            resultError = error
                        default:
                            break
                        }
                    } receiveValue: { (_) in
                    }
                
                expect(resultError).toNot(beNil())
                expect((resultError as? DomoticzMessageError)?.errorMessage().message).to(equal("lorem ipsum"))
                sub.cancel()
            }
            
            it("should publish parsed response from http client") {
                let response = HttpResponse(data: Data([0,1,2]), responseHeaders: [:])
                httpClientMock.call_returnValue = Just<HttpResponse>(response).setFailureType(to: Error.self).eraseToAnyPublisher()
                parserMock.parse_return_value = ResponseDTO(status: "SuperTestStatus")
                var receivedValue: ResponseDTO?
                
                let sub = sut.get(url: .sample(), params: [:], headers: [:], type: ResponseDTO.self)
                    .sink { (_) in
                    } receiveValue: { (value) in
                        receivedValue = value
                    }
                
                expect(parserMock.parse_called).to(beTrue())
                expect(parserMock.parse_parms_data?.count).to(equal(3))
                expect(receivedValue?.status).to(equal("SuperTestStatus"))
                
                sub.cancel()
            }
        }
    }
}
