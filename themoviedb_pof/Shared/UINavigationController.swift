//
//  UINavigationController.swift
//  themoviedb_pof
//
//  Created by Elizabeth Rudenko on 23.04.2018.
//  Copyright © 2018 Roman Ustiantcev. All rights reserved.
//

import UIKit.UINavigationController
import RIBs

extension UINavigationController: ViewControllable {
    
    public var uiviewController: UIViewController { return self }
    
    public convenience init(root: ViewControllable) {
        self.init(rootViewController: root.uiviewController)
    }
}
