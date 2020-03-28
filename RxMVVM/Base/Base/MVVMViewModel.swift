//
//  MVVMViewModel.swift
//  RxMVVM
//
//  Created by Dmitry Y. on 3/28/20.
//  Copyright © 2020 Dmitry Y. All rights reserved.
//

import Foundation


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

    final func viewWillAppear(_ animated: Bool) { }

    final func viewDidAppear(_ animated: Bool) { }

    final func viewWillDisappear(_ animated: Bool) { }

    final func viewDidDisappear(_ animated: Bool) { }
}
