//
//  SETTINGS.swift
//  themoviedb_pof
//
//  Created by Elizabeth Rudenko on 19.04.2018.
//  Copyright © 2018 Roman Ustiantcev. All rights reserved.
//

import Foundation

struct ClientConfig {
    
    // MARK: API Key
    static let ApiKey = "###ADD_API_KEY###"
        
    // MARK: URLs
    static let ApiScheme = "https://"
    static let ApiHost = "api.themoviedb.org"
    static let ApiPath = "/3"
    
    static let AuthorizationURL = "https://www.themoviedb.org/authenticate/"
    static let AccountURL = "https://www.themoviedb.org/account/"
    
    static let ImageURL = "http://image.tmdb.org/t/p/w185/"
    
    // MARK: Account
    static let Account = "/account"
    
    // MARK: Authentication
    static let AuthenticationTokenNew = "/authentication/token/new"
    static let AuthenticationSessionNew = "/authentication/session/new"
    static let AllowToken = "/allow"
    static let DenyToken = "/deny"
    
    // MARK: Search
    static let SearchMovie: String = {
        return "/search/" + Movie
    }()
    
    static let Movie: String = {
        return "movie"
    }()
    
    // MARK: Detail Movie
    static let DetailMovie = "/movie/"
    
    // MARK: Favorite
    static let Favorite: String = {
        return Account + "/{account_id}/favorite"
    }()
    
    // MARK: Favorive movies
    static let FavoriteMovies: String = {
        return Favorite + "/movies"
    }()
    
    // MARK: Top movies
    static let TopMovies: String = {
        return DetailMovie + "top_rated"
    }()
    
    // MARK: Parameter Keys
    struct ParameterKeys {
        static let ApiKey = "api_key"
        static let SessionID = "session_id"
        static let RequestToken = "request_token"
        static let Query = "query"
        static let Page = "page"
    }
}
