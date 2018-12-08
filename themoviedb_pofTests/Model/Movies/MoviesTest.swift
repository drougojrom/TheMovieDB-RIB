//
//  MoviesTest.swift
//  themoviedb_pofTests
//
//  Created by Elizabeth Rudenko on 03.05.2018.
//  Copyright © 2018 Roman Ustiantcev. All rights reserved.
//

import XCTest
@testable import themoviedb_pof

class MoviesTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testMoviesModel() {
        let json = getJSON(resourse: "movies")!
        let movies = Movies(json)
        
        XCTAssertEqual(movies.page, 1)
        XCTAssertEqual(movies.total_pages, 1)
        XCTAssertEqual(movies.total_results, 4)
        XCTAssertEqual(movies.results?.count, 4)
    }
}
