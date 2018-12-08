//
//  MovieDetailServiceTest.swift
//  themoviedb_pofTests
//
//  Created by Roman Ustiantcev on 26/04/2018.
//  Copyright © 2018 Roman Ustiantcev. All rights reserved.
//

import XCTest
@testable import themoviedb_pof


class MovieDetailServiceTest: XCTestCase {
    
    lazy var movieDetailService = MovieDetailService()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    
    func testMovieDetailService() {

        movieDetailService.getMovieWithId("551", completionHandler: { (movie) in
            
        }) { (error) in
            print(error ?? "error")
            XCTFail()
        }
    }
    
}
