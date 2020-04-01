//
//  AlbumViewController.swift
//  RxMVVM
//
//  Created by Dmitry Y. on 3/28/20.
//  Copyright © 2020 Dmitry Y. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

protocol AlbumViewControllerInterface: UIViewController {
    
    var comics: PublishSubject<[Comics]> { get }
    
}

final class ComicsViewController<ViewModel: AlbumViewModel>: MVVMViewController<ComicsView, ViewModel>, AlbumViewControllerInterface, UICollectionViewDelegateFlowLayout {
    
    
    let comics: PublishSubject<[Comics]> = PublishSubject()
    
    
    private let disposeBag = DisposeBag()
    
    
    override func contentViewDidLoad(_ view: ComicsView) {
        super.contentViewDidLoad(view)
        
        view.collectionView.delegate = self
    }
    
    override func bind(view: ComicsView) {
        super.bind(view: view)
        
        
        comics.bind(to: view.collectionView.rx.items(cellIdentifier: ComicsCollectionViewCell.reuseId, cellType: ComicsCollectionViewCell.self)) { row, item, cell in
            cell.comics = item
        }.disposed(by: disposeBag)
        
    }
    
    
    //MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.bounds.height - 20.0
        let width = height / 1.5
        return CGSize(width: width, height: height)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
}
