//
//  HeroDetailViewModel.swift
//  RxMVVM
//
//  Created by Dmitry Y. on 4/23/20.
//  Copyright © 2020 Dmitry Y. All rights reserved.
//

import Foundation
import Foundation
import RxSwift

protocol HeroDetailViewModelInterface {
    
}

final class HeroDetailViewModel: MVVMViewModel, HeroDetailViewModelInterface {
    
    private let disposeBag = DisposeBag()
    
    
    override func onBind() {
        super .onBind()
        
    }
}
