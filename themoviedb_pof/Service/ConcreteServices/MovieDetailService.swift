//
//  MovieDetailService.swift
//  themoviedb_pof
//
//  Created by Roman Ustiantcev on 26/04/2018.
//  Copyright © 2018 Roman Ustiantcev. All rights reserved.
//

import Foundation

class MovieDetailService: RootApiController {
    
    func getMovieWithId(_ id: String, completionHandler: @escaping(Movie)->(), errorHandler: @escaping(String?)->()) {
        
        getData(method: .get,
                endpoint: ClientConfig.DetailMovie + id,
                parameters:  [ClientConfig.ParameterKeys.ApiKey: ClientConfig.ApiKey],
                completionHandler: { (response) in
            DispatchQueue.main.async {
                completionHandler(Movie(response.json))
            }
        }) { (error) in
            DispatchQueue.main.async {
                errorHandler(error.debugDescription)
            }
        }
    }
}
