//
//  MovieSearchServiceTest.swift
//  themoviedb_pofTests
//
//  Created by Roman Ustiantcev on 02/05/2018.
//  Copyright © 2018 Roman Ustiantcev. All rights reserved.
//

import XCTest
@testable import themoviedb_pof


class MovieSearchServiceTest: XCTestCase {
    
    lazy var moviesSearchService = SearchService()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testMoviesSearchService() {
        
        let urlParams : [String: String] = [
            "api_key":"1e9233df039830d72cb53a44f1aa597f",
            "query":"fight",
            "page":"1",
            ]
        
        moviesSearchService.searchMovies(urlParams, completionHandler: { (movies) in
            
        }) { (error) in
            print(error?.description as Any)
            XCTFail()
        }
        
    }
    
    
}
