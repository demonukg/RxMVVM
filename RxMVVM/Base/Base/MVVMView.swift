//
//  MVVMView.swift
//  RxMVVM
//
//  Created by Dmitry Y. on 3/28/20.
//  Copyright © 2020 Dmitry Y. All rights reserved.
//

import Foundation
import UIKit

protocol NibInstantiatable: AnyObject {
  
    static var nib: UINib { get }
}

extension NibInstantiatable {
    
  static var bundle: Bundle {
    return Bundle(for: Self.self)
  }
  
  static func instantiate(owner: Any? = nil, options: [UINib.OptionsKey : Any]? = nil) -> Self {
    return self.nib.instantiate(withOwner: owner, options: options)[0] as! Self
  }
}

protocol Initializable {
    init()
}

class MVVMView: UIView, Initializable {
  
    override class var requiresConstraintBasedLayout: Bool {
        return true
    }

    required init() {
        super.init(frame: .zero)
        addSubviews()
        makeConstraints()
    }

    @available(*, unavailable)
    override init(frame: CGRect) {
        fatalError("init(frame:) has not been implemented")
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addSubviews() { }

    func makeConstraints() { }
    
}

