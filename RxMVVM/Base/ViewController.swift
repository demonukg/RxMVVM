//
//  ViewController.swift
//  RxMVVM
//
//  Created by Dmitry Y. on 3/28/20.
//  Copyright © 2020 Dmitry Y. All rights reserved.
//

import UIKit

protocol ViewControllerInterface {
  
    associatedtype ContentView: UIView

    var contentView: ContentView { get }
}

extension ViewControllerInterface where Self: UIViewController {
  
    var contentView: ContentView {
        return view as! ContentView
    }
}


class ViewController<ContentView: UIView>: UIViewController, ViewControllerInterface {
  
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) not supported by ViewController")
    }

    override func loadView() {
        if ContentView.self is Initializable.Type {
            view = ContentView.init()
            return
        }

        if let nibInitializable = ContentView.self as? NibInstantiatable.Type {
            view = (nibInitializable.instantiate(owner: self, options: nil) as! ContentView)
            return
        }

        fatalError("\(ContentView.self) should be Initializable or NibInstantiatable or \(#function) should be overriden")
    }
}

