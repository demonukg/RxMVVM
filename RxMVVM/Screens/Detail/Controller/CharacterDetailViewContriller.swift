//
//  CharacterDetailViewContriller.swift
//  RxMVVM
//
//  Created by Dmitry Y. on 4/23/20.
//  Copyright © 2020 Dmitry Y. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

protocol CharacterDetailViewContrillerInterface: AnyObject {
    
}

final class CharacterDetailViewContriller<ViewModel: CharacterDetailViewModelInterface>: MVVMViewController<CharacterDetailView, ViewModel>, CharacterDetailViewContrillerInterface {
    
    private var chatacter: Character
    
    init(viewModel: ViewModel, character: Character) {
        chatacter = character
        super.init(viewModel: viewModel)
    }
    
    override func contentViewDidLoad(_ view: CharacterDetailView) {
        super.contentViewDidLoad(view)
        
        navigationItem.title = chatacter.name
        view.character = chatacter
    }
    
    override func bind(view: CharacterDetailView) {
        super.bind(view: view)
        
    }
    
    override func bind(viewModel: ViewModel) {
        super.bind(viewModel: viewModel)
        
    }
    
    override func bind(viewModel: ViewModel, to view: CharacterDetailView) {
        super.bind(viewModel: viewModel, to: view)
        
    }

    
}
