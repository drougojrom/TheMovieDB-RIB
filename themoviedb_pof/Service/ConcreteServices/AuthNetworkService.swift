//
//  AuthNetworkService.swift
//  themoviedb_pof
//
//  Created by Elizabeth Rudenko on 19.04.2018.
//  Copyright © 2018 Roman Ustiantcev. All rights reserved.
//

import Foundation

class AuthNetworkService: RootApiController {
    
    func createRequestToken(completionHandler: @escaping()->(), errorHandler: @escaping(_ error: String?)->()) {
        getData(method: .get,
                endpoint: ClientConfig.AuthenticationTokenNew,
                parameters: [ClientConfig.ParameterKeys.ApiKey: ClientConfig.ApiKey],
                completionHandler: { (response) in
                    DispatchQueue.main.async {
                        User.updateCurrentUser(response.json)
                        completionHandler()
                    }
        }) { (error) in
            DispatchQueue.main.async {
                errorHandler(error)
            }
            
        }
    }
    
    func createSessionId(completionHandler: @escaping(_ session: Bool?)->(), errorHandler: @escaping(_ error: String?)->()) {
        
        let Token: String = User.getCurrentUser().request_token!
        
        getData(method: .get,
                endpoint: ClientConfig.AuthenticationSessionNew,
                parameters: [ClientConfig.ParameterKeys.ApiKey: ClientConfig.ApiKey,
                             ClientConfig.ParameterKeys.RequestToken: Token],
                completionHandler: { (response) in
                    DispatchQueue.main.async {
                        User.updateCurrentUser(response.json)
                        completionHandler(true)
                    }
        }) { (error) in
            DispatchQueue.main.async {
                errorHandler(error)
            }
        }
    }
    
    func getAccountDetails(errorHandler: @escaping(String?)->()) {
                
        let Session: String = User.getCurrentUser().session_id!
        
        getData(method: .get,
                endpoint: ClientConfig.Account,
                parameters: [ClientConfig.ParameterKeys.ApiKey: ClientConfig.ApiKey,
                             ClientConfig.ParameterKeys.SessionID: Session],
                completionHandler: { (response) in
                    DispatchQueue.main.async {
                         User.updateCurrentUser(response.json)
                    }
        },
                errorHandler: { (error) in
                    DispatchQueue.main.async {
                        errorHandler(error)
                    }
        })
    }
}
