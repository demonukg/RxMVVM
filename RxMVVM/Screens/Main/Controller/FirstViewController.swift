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
    
}
