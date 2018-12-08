//
//  currentUser.swift
//  themoviedb_pof
//
//  Created by Elizabeth Rudenko on 24.04.2018.
//  Copyright © 2018 Roman Ustiantcev. All rights reserved.
//

import RealmSwift
import SwiftyJSON

extension User {
    class func updateCurrentUser(_ json: JSON) {
        let existData = User.getCurrentUser()
        let user = User()
        user.update(json: json)
        
        if user.request_token == nil {
            user.request_token = existData.request_token ?? nil
        }
        
        if user.session_id == nil {
            user.session_id = existData.session_id ?? nil
        }
        
        try! uiRealm.write {
            uiRealm.add(user, update: true)
        }
    }
    
    class func getCurrentUser() -> User {
        if let user = uiRealm?.object(ofType: User.self, forPrimaryKey: "current_user") {
            return user
        } else {
            let user = User(json: JSON.null)
            
            try! uiRealm?.write({
                uiRealm?.add(user, update: true)
            })
            return user
        }
    }
    
    class func updateCurrentSession(_ sessionId: String) {
        let user = User.getCurrentUser()
        user.session_id = sessionId
        
        try! uiRealm.write {
            uiRealm.add(user, update: true)
        }
    }
    
    class func logout() {
        try! uiRealm.write {
            uiRealm.deleteAll()
        }
    }
}
