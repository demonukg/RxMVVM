//
//  TrackViewController.swift
//  RxMVVM
//
//  Created by Dmitry Y. on 3/28/20.
//  Copyright © 2020 Dmitry Y. All rights reserved.
//

import Foundation
import UIKit

protocol TrackViewControllerInterface: UIViewController {
    
}

final class TrackViewController<ViewModel: TrackViewModel>: MVVMViewController<TrackView, ViewModel>, TrackViewControllerInterface {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
}
