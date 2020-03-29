//
//  MVVMCollectionViewCell.swift
//  RxMVVM
//
//  Created by Dmitry Y. on 3/28/20.
//  Copyright © 2020 Dmitry Y. All rights reserved.
//

import Foundation
import UIKit

class MVVMCollectionViewCell: UICollectionViewCell, Initializable {
  
    override class var requiresConstraintBasedLayout: Bool {
        return true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        makeConstraints()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addSubviews() { }

    func makeConstraints() { }
    
}
