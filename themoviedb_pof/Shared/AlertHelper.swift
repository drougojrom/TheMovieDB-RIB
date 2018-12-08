//
//  AlertHelper.swift
//  themoviedb_pof
//
//  Created by Elizabeth Rudenko on 18.04.2018.
//  Copyright © 2018 Roman Ustiantcev. All rights reserved.
//

import UIKit.UIAlertController

class SwiftyAlert {
    
    static let shared = SwiftyAlert()
    
    static func AlertHelper(stringMessage: String, vc: UIViewController) {
        //create the alert controller
        let alert = UIAlertController.init(title: String(), message: stringMessage, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        //present the controller
        vc.present(alert, animated: true, completion: nil)
    }
}

