//
//  SearchService.swift
//  themoviedb_pof
//
//  Created by Roman Ustiantcev on 02/05/2018.
//  Copyright © 2018 Roman Ustiantcev. All rights reserved.
//

import Foundation

class SearchService: RootApiController {
        
    func searchMovies(_ parameters: [String: String], completionHandler: @escaping(Movies)->(), errorHandler: @escaping(String?)->()) {
        
        getData(method: .get, endpoint: ClientConfig.SearchMovie, parameters: parameters, completionHandler: { (response) in
            let movies = Movies(response.json)
            DispatchQueue.main.async {
                completionHandler(movies)
            }
        }) { (error) in
            DispatchQueue.main.async {
                errorHandler(error)
            }
        }
    }
}
