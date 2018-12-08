//
//  Genre.swift
//  themoviedb_pof
//
//  Created by Roman Ustiantcev on 26/04/2018.
//  Copyright © 2018 Roman Ustiantcev. All rights reserved.
//

import SwiftyJSON

protocol GenreProtocol: class {
    var id: Int {get}
    var name: String? {get}
}

class Genre: GenreProtocol {
    
    var id: Int = 0
    var name: String? = nil
    
    convenience init(_ json: JSON) {
        self.init()
        
        if let id = json["id"].int {
            self.id = id
        }
        
        if let name = json["name"].string {
            self.name = name
        }
    }
}
