//
//  BaseViewController.swift
//  RxMVVM
//
//  Created by Dmitry Y. on 3/28/20.
//  Copyright © 2020 Dmitry Y. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import RxDataSources

protocol BaseViewControllerInterface: UIViewController {
    
    //var comics: PublishSubject<[Comics]> { get }
    
}

final class BaseViewController<ViewModel: BaseViewModel>: MVVMViewController<BaseView, ViewModel>, BaseViewControllerInterface, UICollectionViewDelegateFlowLayout {
    
    //let comics: PublishSubject<[Comics]> = PublishSubject()
    
    let disposeBag = DisposeBag()
    
    let dataSource = RxCollectionViewSectionedReloadDataSource<SectionModel<String, Comics>>(
        configureCell: { (_, collectionView, indexPath, item: Comics) in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ComicsCollectionViewCell.reuseId, for: indexPath) as! ComicsCollectionViewCell
            cell.comics = item
            return cell
        }
    )
    
    
    
    
    private var trackController: TrackViewControllerInterface! {
        didSet {
            addChild(trackController)
            contentView.addTrackView(trackController.view)
            trackController.didMove(toParent: self)
        }
    }
    
    override func contentViewDidLoad(_ view: BaseView) {
        super.contentViewDidLoad(view)
        
        trackController = TrackViewController(viewModel: TrackViewModel())
        
    }
    
    override func bind(view: BaseView) {
        super.bind(view: view)
        
        view.collectionView
            .rx.setDelegate(self)
            .disposed(by: disposeBag)
        
    }
    
    override func bind(viewModel: ViewModel) {
        super.bind(viewModel: viewModel)
        
        viewModel.loading
            .bind(to: self.rx.isAnimating)
            .disposed(by: disposeBag)
        
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
    
    override func bind(viewModel: ViewModel, to view: BaseView) {
        super.bind(viewModel: viewModel, to: view)
        
        viewModel.comics
            .map { [SectionModel(model: "Comics", items: $0)] }
            .bind(to: view.collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        
//        viewModel.comics
//            .bind(to: view.collectionView.rx.items(cellIdentifier: ComicsCollectionViewCell.reuseId, cellType: ComicsCollectionViewCell.self)) { row, item, cell in
//                cell.comics = item
//        }.disposed(by: disposeBag)
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
