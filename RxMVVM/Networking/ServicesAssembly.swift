//
//  ServicesAssembly.swift
//  RxMVVM
//
//  Created by Dmitry Y. on 5/2/20.
//  Copyright © 2020 Dmitry Y. All rights reserved.
//

import Swinject

struct ServicesAssembly: Assembly {
    
    func assemble(container: Container) {
        
        container.register(NetworkingInterface.self) { _ in Networking() }
            .inObjectScope(.container)
        
    }
    
}
