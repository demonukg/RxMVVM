//
//  AlbumViewController.swift
//  RxMVVM
//
//  Created by Dmitry Y. on 3/28/20.
//  Copyright © 2020 Dmitry Y. All rights reserved.
//

import Foundation
import UIKit

protocol AlbumViewControllerInterface: UIViewController {
    
}

final class AlbumViewController<ViewModel: AlbumViewModel>: MVVMViewController<AlbumView, ViewModel>, AlbumViewControllerInterface {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
}
