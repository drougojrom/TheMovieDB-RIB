//
//  MovieConstants.swift
//  themoviedb_pof
//
//  Created by Elizabeth Rudenko on 27.05.2018.
//  Copyright © 2018 Roman Ustiantcev. All rights reserved.
//

import Foundation

struct MovieConstants {
    
    // for builder
    static let ViewController = "MovieViewController"
    
    // MARK: Parameter for body json
    // markMovieAsFavorite
    struct Parameter {
        static let MediaType = "media_type"
        static let MediaId = "media_id"
        static let Favorite = "favorite"
        static let Movie = "movie"
    }
    
    // MARK: Error
    // routToPosterMovie
    static let RoutToPosterMovieError = "error poster image"
    
}
