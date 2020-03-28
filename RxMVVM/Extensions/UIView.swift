//
//  UIView.swift
//  RxMVVM
//
//  Created by Dmitry Y. on 3/28/20.
//  Copyright © 2020 Dmitry Y. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

extension UIView {
    
    func addFullSubview(_ subview: UIView) {
        addSubview(subview)
        constraintFullSubview(subview)
    }
    
    private func constraintFullSubview(_ subview: UIView) {
        subview.snp.makeConstraints {
            $0.edges.equalTo(self)
        }
    }
    
}
