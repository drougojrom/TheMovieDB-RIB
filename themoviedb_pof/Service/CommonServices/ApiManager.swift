//
//  ApiManager.swift
//
//
//  Created by Roman Ustiantcev on 11/23/17.
//  Copyright © 2017 Roman Ustiantcev. All rights reserved.
//

import Alamofire

class ApiManager {
    
    static let sharedInstance: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 4
        configuration.timeoutIntervalForResource = 4
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        
        return SessionManager(configuration: configuration)
    }()
}
