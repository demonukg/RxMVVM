//
//  FirstView.swift
//  RxMVVM
//
//  Created by Dmitry Y. on 3/28/20.
//  Copyright © 2020 Dmitry Y. All rights reserved.
//

import Foundation
import UIKit

final class FirstView: MVVMView {
    
    required init() {
        super.init()
        backgroundColor = .red
    }
    
    override func addSubviews() {
        print("FirstView addSubviews")
    }
}
