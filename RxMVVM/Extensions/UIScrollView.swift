//
//  UIScrollView.swift
//  RxMVVM
//
//  Created by Dmitry Y. on 4/12/20.
//  Copyright © 2020 Dmitry Y. All rights reserved.
//

import Foundation
import UIKit

extension UIScrollView {
    func isNearVerticalEdge(edgeOffset: CGFloat = 20.0) -> Bool {
        return self.contentOffset.y + self.frame.size.height + edgeOffset > self.contentSize.height
    }
    
    func isNearHorizontalEdge(edgeOffset: CGFloat = 20.0) -> Bool {
        return self.contentOffset.x + self.frame.size.width + edgeOffset > self.contentSize.width
    }
}
