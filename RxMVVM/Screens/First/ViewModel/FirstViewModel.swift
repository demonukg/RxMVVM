//
//  FirstViewModel.swift
//  RxMVVM
//
//  Created by Dmitry Y. on 3/28/20.
//  Copyright © 2020 Dmitry Y. All rights reserved.
//

import Foundation

final class FirstViewModel: MVVMViewModel {
    
    var test = "xz"
    
    override init() {
        super.init()
        print("FirstViewModel init")
    }
    
    
}
