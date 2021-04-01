//
//  HttpRequest.swift
//  
//
//  Created by Michał Solski on 31/03/2021.
//

import Foundation

typealias HttpHeaderKey = String
typealias HttpHeaderValue = String
typealias HttpParamKey = String
typealias HttpParamValue = String
typealias HttpHeaders = [HttpHeaderKey: HttpHeaderValue]
typealias HttpParams = [HttpParamKey: HttpParamValue]

struct HttpRequest {
    let url: URL
    let params: HttpParams
    let headers: HttpHeaders
    let method: HttpMethod
}

enum HttpMethod: Int {
    case post
    case get
}
