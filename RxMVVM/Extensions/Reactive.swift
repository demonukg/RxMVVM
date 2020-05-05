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

public extension Reactive where Base: UIScrollView {

    func reachedBottom(offset: CGFloat = 0.0) -> ControlEvent<Void> {
        let source = contentOffset.map { contentOffset in
            let visibleHeight = self.base.frame.height - self.base.contentInset.top - self.base.contentInset.bottom
            let y = contentOffset.y + self.base.contentInset.top
            let threshold = max(offset, self.base.contentSize.height - visibleHeight)
            return y >= threshold
        }
        .distinctUntilChanged()
        .filter { $0 }
        .map { _ in () }
        return ControlEvent(events: source)
    }
}

public extension Reactive where Base: UIScrollView {

    func reachedEdge(offset: CGFloat = 0.0) -> ControlEvent<Void> {
        let source = contentOffset.map { contentOffset in
            let visibleWidth = self.base.frame.width - self.base.contentInset.left - self.base.contentInset.right
            let x = contentOffset.x + self.base.contentInset.left
            let threshold = max(offset, self.base.contentSize.width - visibleWidth)
            return x >= threshold
        }
        .distinctUntilChanged()
        .filter { $0 }
        .map { _ in () }
        return ControlEvent(events: source)
    }
}
