//
//  MVVMTableViewCell.swift
//  RxMVVM
//
//  Created by Dmitry Y. on 3/28/20.
//  Copyright © 2020 Dmitry Y. All rights reserved.
//

import Foundation
import UIKit

class MVVMTableViewCell: UITableViewCell, Initializable {
  
    override class var requiresConstraintBasedLayout: Bool {
        return true
    }

    required init() {
        super.init(style: .default, reuseIdentifier: nil)
        addSubviews()
        makeConstraints()
    }

    @available(*, unavailable)
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        fatalError("init(frame:) has not been implemented")
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addSubviews() { }

    func makeConstraints() { }
    
}
