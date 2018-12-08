//
//  UIViewControllerHelper.swift
//  themoviedb_pof
//
//  Created by Elizabeth Rudenko on 25.05.2018.
//  Copyright © 2018 Roman Ustiantcev. All rights reserved.
//

import UIKit.UIViewController

extension UIViewController
{
    class func instantiateFromStoryboard(_ name: String) -> UIViewController
    {
        let storyboard = UIStoryboard(name: name, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: name)
        return viewController
    }
}
