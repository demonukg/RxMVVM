//
//  Reactive.swift
//  RxMVVM
//
//  Created by Dmitry Y. on 3/29/20.
//  Copyright © 2020 Dmitry Y. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import NVActivityIndicatorView

extension Reactive where Base: UIViewController & NVActivityIndicatorViewable {
    
    /// Bindable sink for `startAnimating()`, `stopAnimating()` methods.
    public var isAnimating: Binder<Bool> {
        return Binder(self.base, binding: { (vc, active) in
            if active {
                vc.startAnimating()
            } else {
                vc.stopAnimating()
            }
        })
    }
    
}
