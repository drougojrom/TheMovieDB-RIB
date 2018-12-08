//
//  TopMoviesService.swift
//  themoviedb_pof
//
//  Created by Elizabeth Rudenko on 10.05.2018.
//  Copyright © 2018 Roman Ustiantcev. All rights reserved.
//

import Foundation

class TopMoviesService: RootApiController {
    
    func getTopMoviesServiceOnPage(_ page: Int, completionHandler: @escaping(Movies)->(), errorHandler: @escaping(String?)->()) {
        getData(method: .get,
                endpoint: ClientConfig.TopMovies,
                parameters: [ClientConfig.ParameterKeys.ApiKey: ClientConfig.ApiKey,
                             ClientConfig.ParameterKeys.Page: String(page)],
                completionHandler: { (response) in
                    DispatchQueue.main.async {
                        completionHandler(Movies(response.json))
                    }
        }) { (error) in
            DispatchQueue.main.async {
                errorHandler(error)
            }
        }
    }
}
