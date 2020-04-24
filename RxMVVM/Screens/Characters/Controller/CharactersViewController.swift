//
//  CharactersViewController.swift
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

protocol CharactersViewControllerInterface: AnyObject {
    
}

final class CharactersViewController<ViewModel: CharactersViewModelInterface>: MVVMViewController<CharacterView, ViewModel>, CharactersViewControllerInterface {
    
    override func bind(view: CharacterView) {
        super.bind(view: view)
        
    }
    
    override func bind(viewModel: ViewModel) {
        super.bind(viewModel: viewModel)
        
    }
    
    override func bind(viewModel: ViewModel, to view: CharacterView) {
        super.bind(viewModel: viewModel, to: view)
        
    }

    
}
