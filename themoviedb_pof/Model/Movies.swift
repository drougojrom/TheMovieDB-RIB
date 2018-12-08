//
//  FavoriteMovies.swift
//  themoviedb_pof
//
//  Created by Elizabeth Rudenko on 28.04.2018.
//  Copyright © 2018 Roman Ustiantcev. All rights reserved.
//

import SwiftyJSON

protocol MoviesProtocol: class {
    var page: Int? {get}
    var total_pages: Int? {get}
    var total_results: Int? {get}
    var results: [MovieProtocol]? {get}
}

class Movies: MoviesProtocol {
    
    var page: Int? = nil
    var total_pages: Int? = nil
    var total_results: Int? = nil
    var results: [MovieProtocol]? = nil
    
    convenience init(_ json: JSON) {
        self.init()
        
        if let page = json["page"].int {
            self.page = page
        }
        
        if let total_pages = json["total_pages"].int {
            self.total_pages = total_pages
        }
        
        if let total_results = json["total_results"].int {
            self.total_results = total_results
        }
        
        if let results = json["results"].array {
            self.results = results.map { Movie($0) }
        }
    }
}
