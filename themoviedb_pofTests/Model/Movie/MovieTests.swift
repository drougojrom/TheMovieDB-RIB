//
//  MovieTests.swift
//  themoviedb_pofTests
//
//  Created by Roman Ustiantcev on 26/04/2018.
//  Copyright © 2018 Roman Ustiantcev. All rights reserved.
//

import XCTest
@testable import themoviedb_pof


class MovieTests: XCTestCase {

    override func setUp() {
        super.setUp()

    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testMovieModel() {
        let json = getJSON(resourse: "movie")!
        let movie = Movie(json)
        
        XCTAssertEqual(movie.id, 551)
        XCTAssertEqual(movie.originalTitle!, "The Poseidon Adventure")
        XCTAssertEqual(movie.overview!, "The Poseidon Adventure was one of the first Catastrophe films and began the Disaster Film genre. Director Neame tells the story of a group of people that must fight for their lives aboard a sinking ship. Based on the novel by Paul Gallico.")
        XCTAssertEqual(movie.releaseDate, "1972-12-01")
        XCTAssertEqual(movie.tagline, "Who will survive-in one of the greatest escape adventures ever!")
        XCTAssertEqual(movie.voteAverage, 7.3)
        XCTAssertEqual(movie.voteCount, 325)
        XCTAssertEqual(movie.posterPath, "/o7mRqnYg3YJNXxHUWa0TeSzR84d.jpg")

    }
    
}
