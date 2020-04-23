//
//  HeroesViewModel.swift
//  RxMVVM
//
//  Created by Dmitry Y. on 4/23/20.
//  Copyright © 2020 Dmitry Y. All rights reserved.
//

import Foundation
import RxSwift

protocol HeroesViewModelInterface {
    
}

final class HeroesViewModel: MVVMViewModel, HeroesViewModelInterface {
    
    private let disposeBag = DisposeBag()
    
    
    override func onBind() {
        super .onBind()
        
    }
}
