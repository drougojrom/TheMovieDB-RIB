//
//  ScrollViewHelper.swift
//  themoviedb_pof
//
//  Created by Elizabeth Rudenko on 18.05.2018.
//  Copyright © 2018 Roman Ustiantcev. All rights reserved.
//

import UIKit.UIScrollView

extension UIScrollView {
    func  isNearBottomEdge(edgeOffset: CGFloat = 20.0) -> Bool {
        return self.contentOffset.y + self.frame.size.height + edgeOffset > self.contentSize.height
    }
}
