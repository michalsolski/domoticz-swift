//
//  DomoticzServerConsts.swift
//  
//
//  Created by Michał Solski on 03/04/2021.
//

import Foundation

struct DomoticzServerConsts {
    
    static let apiPath = "json.htm"
    
    struct Headers {
        static let authHeaderKey = "Authorization"
    }
    
    struct Params {
        static let devices: HttpParams = ["type": "devices"]
    }
    
    struct Responses {
        static let statusOk = "OK"
    }
    
}
