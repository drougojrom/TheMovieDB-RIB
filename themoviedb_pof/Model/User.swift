//
//  AuthRequestModel.swift
//  themoviedb_pof
//
//  Created by Elizabeth Rudenko on 18.04.2018.
//  Copyright © 2018 Roman Ustiantcev. All rights reserved.
//

import SwiftyJSON
import RealmSwift

class User: Object {
    
    @objc dynamic var current_user: String? = "current_user"
    @objc dynamic var request_token: String? = nil
    @objc dynamic var session_id: String? = nil
    @objc dynamic var username: String? = nil
    
    convenience init(json: JSON?) {
        self.init()
        if let json = json {
            update(json: json)
        }
    }
    
    override static func primaryKey() -> String? {
        return "current_user"
    }
    
    func update(json: JSON) {
        if let request_token = json["request_token"].string {
            self.request_token = request_token
        }
        
        if let session_id = json["session_id"].string {
            self.session_id = session_id
        }
        
        if let username = json["username"].string {
            self.username = username
        }
    }
}
