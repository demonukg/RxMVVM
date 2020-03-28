//
//  MVVMViewController.swift
//  RxMVVM
//
//  Created by Dmitry Y. on 3/28/20.
//  Copyright © 2020 Dmitry Y. All rights reserved.
//

import Foundation
import UIKit

protocol MVVMViewControllerInterface: ViewControllerInterface {
  
    associatedtype ViewModel: MVVMViewModelInterface

    var viewModel: ViewModel { get }
    
}

class MVVMViewController<ContentView: UIView, ViewModel: MVVMViewModelInterface>: ViewController<ContentView>, MVVMViewControllerInterface {
  
  let viewModel: ViewModel
  
  init(viewModel: ViewModel) {
    self.viewModel = viewModel
    super.init()
  }
  
  final override func viewDidLoad() {
    super.viewDidLoad()
    
    contentViewDidLoad(contentView)
    
    bind(view: contentView)
    bind(viewModel: viewModel)
    bind(viewModel: viewModel, to: contentView)
    viewModel.onBind()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    viewModel.viewWillAppear(animated)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    viewModel.viewDidAppear(animated)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    viewModel.viewWillDisappear(animated)
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    viewModel.viewDidDisappear(animated)
  }
  
  func contentViewDidLoad(_ view: ContentView) { }
  
  func bind(view: ContentView) { }
  
  func bind(viewModel: ViewModel) { }
  
  func bind(viewModel: ViewModel, to view: ContentView) { }

}
