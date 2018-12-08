//
//  XCTest+Helpers.swift
//  themoviedb_pofTests
//
//  Created by Roman Ustiantcev on 26/04/2018.
//  Copyright © 2018 Roman Ustiantcev. All rights reserved.
//

import SwiftyJSON
import XCTest

@testable import themoviedb_pof

extension XCTestCase {
    
    func getJSON(resourse: String) -> JSON? {
        var json: JSON?
        
        let testBundle = Bundle(for: type(of: self))
        if let path = testBundle.path(forResource: resourse, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                json = try JSON(data: data)
                return json
            } catch {
                XCTFail()
            }
        }
        XCTAssertNotNil(json)
        return nil
    }
    
}
