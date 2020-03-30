//
//  AlertControllerFactory.swift
//  RxMVVM
//
//  Created by Dmitry Y. on 3/29/20.
//  Copyright © 2020 Dmitry Y. All rights reserved.
//

import Foundation
import UIKit

enum AlertControllerFactory {
    
    enum AlertControllerType {
        
        case error(error: Error)
        
        case messageWithButton(message: String)
        
    }
    
    static func controller(ofType type: AlertControllerType) -> UIAlertController {
        switch type {
            
        case let .error(error: error):
            let alertController = UIAlertController(title: "Error",
                                                    message: error.localizedDescription,
                                                    preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return alertController
            
        case let .messageWithButton(message):
            let alertController = UIAlertController(title: nil,
                                                    message: message,
                                                    preferredStyle: .alert)
            let closeAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(closeAction)
            return alertController
        }
    }
    
}
