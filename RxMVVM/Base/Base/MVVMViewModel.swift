//
//  MVVMViewModel.swift
//  RxMVVM
//
//  Created by Dmitry Y. on 3/28/20.
//  Copyright © 2020 Dmitry Y. All rights reserved.
//

import Foundation

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
  
    init() { }
    
    func onBind() { }

    func viewWillAppear(_ animated: Bool) { }

    func viewDidAppear(_ animated: Bool) { }

    func viewWillDisappear(_ animated: Bool) { }

    func viewDidDisappear(_ animated: Bool) { }
}
