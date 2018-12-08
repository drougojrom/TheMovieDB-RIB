//
//  Movie.swift
//  themoviedb_pof
//
//  Created by Roman Ustiantcev on 26/04/2018.
//  Copyright © 2018 Roman Ustiantcev. All rights reserved.
//

import SwiftyJSON
import RealmSwift

protocol MovieProtocol: class {
    var id: Int { get }
    var originalTitle: String? { get }
    var overview: String? { get }
    var releaseDate: String? { get }
    var tagline: String? { get }
    var voteAverage: Double { get }
    var voteCount: Int { get }
    var posterPath: String? { get }
    var genres: [GenreProtocol]? { get }
}

class Movie: Object, MovieProtocol {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var originalTitle: String? = nil
    @objc dynamic var overview: String? = nil
    @objc dynamic var releaseDate: String? = nil
    @objc dynamic var tagline: String? = nil
    @objc dynamic var voteAverage: Double = 0
    @objc dynamic var voteCount: Int = 0
    @objc dynamic var posterPath: String? = nil
    var genres: [GenreProtocol]? = nil
    
    
    convenience init(_ json: JSON) {
        self.init()
        
        if let id = json["id"].int {
            self.id = id
        }
        
        if let originalTitle = json["original_title"].string {
            self.originalTitle = originalTitle
        }
        
        if let overview = json["overview"].string {
            self.overview = overview
        }
        
        if let releaseDate = json["release_date"].string {
            self.releaseDate = releaseDate
        }
        
        if let tagline = json["tagline"].string {
            self.tagline = tagline
        }
        
        if let voteAverage = json["vote_average"].double {
            self.voteAverage = voteAverage
        }
        
        if let voteCount = json["vote_count"].int {
            self.voteCount = voteCount
        }
        
        if let posterPath = json["poster_path"].string {
            self.posterPath = posterPath
        }
        
        if let genres = json["genres"].array {
            self.genres = genres.map { Genre($0) }
        }
    }
}
