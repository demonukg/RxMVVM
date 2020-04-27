//
//  CharacterDetailViewContriller.swift
//  RxMVVM
//
//  Created by Dmitry Y. on 4/23/20.
//  Copyright © 2020 Dmitry Y. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

protocol CharacterDetailViewContrillerInterface: AnyObject {
    
}

final class CharacterDetailViewContriller<ViewModel: CharacterDetailViewModelInterface>: MVVMViewController<CharacterDetailView, ViewModel>, CharacterDetailViewContrillerInterface, UICollectionViewDelegateFlowLayout {
    
    private var chatacter: Character
    
    init(viewModel: ViewModel, character: Character) {
        chatacter = character
        super.init(viewModel: viewModel)
    }
    
    override func contentViewDidLoad(_ view: CharacterDetailView) {
        super.contentViewDidLoad(view)
        
        navigationItem.title = chatacter.name
        view.character = chatacter
    }
    
    override func bind(view: CharacterDetailView) {
        super.bind(view: view)
        
        view.collectionView
            .rx.setDelegate(self)
            .disposed(by: disposeBag)
    }
    
    override func bind(viewModel: ViewModel) {
        super.bind(viewModel: viewModel)
        
        viewModel.characterId.onNext(chatacter.id)
    }
    
    override func bind(viewModel: ViewModel, to view: CharacterDetailView) {
        super.bind(viewModel: viewModel, to: view)
        
        viewModel.comics
            .asDriver(onErrorJustReturn: [])
            .drive(view.collectionView.rx.items(cellIdentifier: ComicsCollectionViewCell.reuseId, cellType: ComicsCollectionViewCell.self)) { row, item, cell in
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
