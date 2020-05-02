//
//  Assembler.swift
//  RxMVVM
//
//  Created by Dmitry Y. on 5/2/20.
//  Copyright © 2020 Dmitry Y. All rights reserved.
//

import Swinject

extension Assembler {
    static let shared: Assembler = {
        let container = Container()
        let assembler = Assembler([
            ServicesAssembly(),
            CharactersAssembly(),
            DetailAssembly()
        ], container: container)
        return assembler
    }()
}
