//
//  HeroDetailViewContriller.swift
//  RxMVVM
//
//  Created by Dmitry Y. on 4/23/20.
//  Copyright © 2020 Dmitry Y. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import RxDataSources

protocol HeroDetailViewContrillerInterface: UIViewController {
    
}

final class HeroDetailViewContriller<ViewModel: HeroDetailViewModel>: MVVMViewController<HeroDetailView, ViewModel>, HeroDetailViewContrillerInterface {
    
    override func bind(view: HeroDetailView) {
        super.bind(view: view)
        
    }
    
    override func bind(viewModel: ViewModel) {
        super.bind(viewModel: viewModel)
        
    }
    
    override func bind(viewModel: ViewModel, to view: HeroDetailView) {
        super.bind(viewModel: viewModel, to: view)
        
    }

    
}
