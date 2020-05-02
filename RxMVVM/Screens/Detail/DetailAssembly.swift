//
//  DetailAssembly.swift
//  RxMVVM
//
//  Created by Dmitry Y. on 5/2/20.
//  Copyright © 2020 Dmitry Y. All rights reserved.
//

import Swinject

struct DetailAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(CharacterDetailViewModel.self) { r in
            CharacterDetailViewModel(networkService: r.resolve(NetworkingInterface.self)!)
        }
        container.register(CharacterDetailController.self) { (r, character: Character) in
            CharacterDetailViewController(viewModel: r.resolve(CharacterDetailViewModel.self)!, character: character)
        }
    }
    
}
