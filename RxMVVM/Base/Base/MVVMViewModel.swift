//
//  MVVMViewModel.swift
//  RxMVVM
//
//  Created by Dmitry Y. on 3/28/20.
//  Copyright © 2020 Dmitry Y. All rights reserved.
//

import Foundation
import RxSwift

enum MainError {
    
    case internalError(String)
    
    case serverError(Error)
    
}


protocol MVVMViewModelInterface: AnyObject {
  
    func onBind()

    func viewWillAppear(_ animated: Bool)

    func viewDidAppear(_ animated: Bool)

    func viewWillDisappear(_ animated: Bool)

    func viewDidDisappear(_ animated: Bool)
  
}

class MVVMViewModel: MVVMViewModelInterface {
    
    let willAppear: PublishSubject<Bool> = PublishSubject()
    
    let didAppear: PublishSubject<Bool> = PublishSubject()
    
    let willDisappear: PublishSubject<Bool> = PublishSubject()
    
    let didDisappear: PublishSubject<Bool> = PublishSubject()
    
    let disposeBag = DisposeBag()
  
    init() { }
    
    func onBind() { }

    final func viewWillAppear(_ animated: Bool) {
        willAppear.onNext(animated)
    }

    final func viewDidAppear(_ animated: Bool) {
        didAppear.onNext(animated)
    }

    final func viewWillDisappear(_ animated: Bool) {
        willDisappear.onNext(animated)
    }

    final func viewDidDisappear(_ animated: Bool) {
        didDisappear.onNext(animated)
    }
}
