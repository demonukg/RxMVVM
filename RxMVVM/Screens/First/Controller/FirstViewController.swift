//
//  FirstViewController.swift
//  RxMVVM
//
//  Created by Dmitry Y. on 3/28/20.
//  Copyright © 2020 Dmitry Y. All rights reserved.
//

import Foundation
import UIKit

final class FirstViewController<ViewModel: FirstViewModel>: MVVMViewController<FirstView, ViewModel> {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("FirstViewController viewWillAppear \(viewModel.test)")
    }
    
}
