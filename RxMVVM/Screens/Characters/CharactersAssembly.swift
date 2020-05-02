//
//  CharactersAssembly.swift
//  RxMVVM
//
//  Created by Dmitry Y. on 5/2/20.
//  Copyright © 2020 Dmitry Y. All rights reserved.
//

import Swinject

struct CharactersAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(CharactersViewModel.self) { r in
            CharactersViewModel(networkService: r.resolve(NetworkingInterface.self)!)
        }
        container.register(CharactersController.self) { r in
            CharactersViewController(viewModel: r.resolve(CharactersViewModel.self)!)
        }
    }
    
}
