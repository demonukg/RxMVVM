//
//  HeroesViewController.swift
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

protocol HeroesViewControllerInterface: UIViewController {
    
}

final class HeroesViewController<ViewModel: HeroesViewModel>: MVVMViewController<HeroesView, ViewModel>, HeroesViewControllerInterface {
    
    let disposeBag = DisposeBag()
    
    override func bind(view: HeroesView) {
        super.bind(view: view)
        
    }
    
    override func bind(viewModel: ViewModel) {
        super.bind(viewModel: viewModel)
        
    }
    
    override func bind(viewModel: ViewModel, to view: HeroesView) {
        super.bind(viewModel: viewModel, to: view)
        
    }

    
}
