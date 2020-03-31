//
//  FirstViewController.swift
//  RxMVVM
//
//  Created by Dmitry Y. on 3/28/20.
//  Copyright © 2020 Dmitry Y. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

final class FirstViewController<ViewModel: BaseViewModel>: MVVMViewController<FirstView, ViewModel> {
    
    let disposeBag = DisposeBag()
    
    private var albumController: AlbumViewControllerInterface! {
        didSet {
            addChild(albumController)
            contentView.addAlbumView(albumController.view)
            albumController.didMove(toParent: self)
        }
    }
    
    private var trackController: TrackViewControllerInterface! {
        didSet {
            addChild(trackController)
            contentView.addTrackView(trackController.view)
            trackController.didMove(toParent: self)
        }
    }
    
    override func contentViewDidLoad(_ view: FirstView) {
        super.contentViewDidLoad(view)
        
        albumController = AlbumViewController(viewModel: AlbumViewModel())
        trackController = TrackViewController(viewModel: TrackViewModel())
        
    }
    
    override func bind(viewModel: ViewModel) {
        super.bind(viewModel: viewModel)
        
        viewModel.loading
            .bind(to: self.rx.isAnimating).disposed(by: disposeBag)
        
        viewModel.error
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (error) in
                switch error {
                case .internalError(let error):
                    self.present(AlertControllerFactory.controller(ofType: .messageWithButton(message: error)), animated: true)
                case .serverError(let error):
                    self.present(AlertControllerFactory.controller(ofType: .error(error: error)), animated: true)
                    
                }
            }).disposed(by: disposeBag)
        
    }
    
}
