//
//  CharactersViewModel.swift
//  RxMVVM
//
//  Created by Dmitry Y. on 4/23/20.
//  Copyright © 2020 Dmitry Y. All rights reserved.
//

import Foundation
import RxSwift

protocol CharactersViewModelInterface: MVVMViewModelInterface {
    
}

final class CharactersViewModel: MVVMViewModel, CharactersViewModelInterface {
    
    override func onBind() {
        super .onBind()
        
    }
}
