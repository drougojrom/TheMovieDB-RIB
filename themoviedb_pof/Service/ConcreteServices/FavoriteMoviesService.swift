//
//  FaforiteMoviesService.swift
//  themoviedb_pof
//
//  Created by Elizabeth Rudenko on 28.04.2018.
//  Copyright © 2018 Roman Ustiantcev. All rights reserved.
//

import Foundation

class FavoriteMoviesService: RootApiController {
    
    private let Token = User.getCurrentUser().request_token!
    private let Session = User.getCurrentUser().session_id!
    
    func getFavoriteMovies(completionHandler: @escaping([Movie])->(), errorHandler: @escaping(String?)->()) {
        
        let parameters = [ClientConfig.ParameterKeys.ApiKey: ClientConfig.ApiKey,
                          ClientConfig.ParameterKeys.SessionID: Session]
        
        getData(method: .get,
                endpoint: ClientConfig.FavoriteMovies,
                parameters: parameters,
                completionHandler: { (response) in
                    DispatchQueue.main.async {
                        let moviesData = Movies(response.json)
                        if let movies = moviesData.results {
                            Movie.saveFavoriteMovies(movies)
                        }
                        completionHandler(Movie.getFavoriteMovies())
                    }
        }) { (error) in
            DispatchQueue.main.async {
                errorHandler(error)
            }
        }
    }
    
    func markAsFavorite(body: [String: Any], errorHandler: @escaping(String?)->()) {
        
        let parameters = [ClientConfig.ParameterKeys.ApiKey: ClientConfig.ApiKey,
                          ClientConfig.ParameterKeys.SessionID: Session]
        
        getData(method: .post,
                endpoint: ClientConfig.Favorite,
                parameters: parameters,
                body: body,
                completionHandler: { _ in
        }) { (error) in
            DispatchQueue.main.async {
                errorHandler(error)
            }
        }
    }
}
