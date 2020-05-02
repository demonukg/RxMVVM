//
//  AppCoordinator.swift
//  RxMVVM
//
//  Created by Dmitry Y. on 3/28/20.
//  Copyright © 2020 Dmitry Y. All rights reserved.
//

import Foundation
import UIKit
import Swinject

protocol AppCoordinatorInterface {
    
    var window: UIWindow { get }
    
    init(window: UIWindow)
    
    func start()
    
}

final class AppCoordinator: AppCoordinatorInterface {
    
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        window.rootViewController = UINavigationController(rootViewController: Assembler.shared.resolver.resolve(CharactersController.self)!)
    }
    
    
}
