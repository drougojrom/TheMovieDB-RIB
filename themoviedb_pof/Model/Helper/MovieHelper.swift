//
//  MovieHelper.swift
//  themoviedb_pof
//
//  Created by Elizabeth Rudenko on 16.05.2018.
//  Copyright © 2018 Roman Ustiantcev. All rights reserved.
//

import RealmSwift
import SwiftyJSON

extension Movie {
    class func saveFavoriteMovies(_ movies: [MovieProtocol]) {
        Movie.clearFavoriteMovies()
        for movie in movies {
            try! uiRealm.write {
                uiRealm.create(Movie.self, value: movie, update: false)
            }
        }
    }
    
    class func clearFavoriteMovies() {
        try! uiRealm.write {
            uiRealm.delete(uiRealm.objects(Movie.self))
        }
    }
    
    class func getFavoriteMovies() -> [Movie] {
        var movieResults = [Movie]()
        let results = uiRealm.objects(Movie.self)
        for item in results {
            movieResults.append(item)
        }
        return movieResults
    }
    
    class func isFavorite(movie: Movie) -> Bool {
        var isFavorite = false
        let favoriteMovies = uiRealm.objects(Movie.self)
        for item in favoriteMovies {
            if item.id == movie.id {
                isFavorite = true
            }
        }
        return isFavorite
    }
    
    class func addNewFavoriteMovie(_ movie: Movie) {
        try! uiRealm.write {
            uiRealm.create(Movie.self, value: movie, update: false)
        }
    }
    
    class func removeFavoriteMovie(_ movie: Movie) {
        let movieToRemove = uiRealm.objects(Movie.self).filter("id == %@", movie.id)
        try! uiRealm.write {
            uiRealm.delete(movieToRemove)
        }
    }
}
