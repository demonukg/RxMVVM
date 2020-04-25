//
//  CharactersViewController.swift
//  RxMVVM
//
//  Created by Dmitry Y. on 4/23/20.
//  Copyright © 2020 Dmitry Y. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import RxDataSources

protocol CharactersViewControllerInterface: AnyObject {
    
}

final class CharactersViewController<ViewModel: CharactersViewModelInterface>: MVVMViewController<CharacterView, ViewModel>, CharactersViewControllerInterface {
    
    let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, Character>>(
        configureCell: { _, tableView, indexPath, character in
            let cell = tableView.dequeueReusableCell(withIdentifier: CharacterTableViewCell.reuseId, for: indexPath) as! CharacterTableViewCell
            cell.character = character
            return cell
        }
    )
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func bind(view: CharacterView) {
        super.bind(view: view)
        
        
    }
    
    override func bind(viewModel: ViewModel) {
        super.bind(viewModel: viewModel)
        
        viewModel.error
            .subscribeOn(MainScheduler.instance)
            .subscribe(onNext: { (error) in
                switch error {
                case .internalError(let error):
                    self.present(AlertControllerFactory.controller(ofType: .messageWithButton(message: error)), animated: true)
                case .serverError(let error):
                    self.present(AlertControllerFactory.controller(ofType: .error(error: error)), animated: true)
                }
            }).disposed(by: disposeBag)
        
    }
    
    override func bind(viewModel: ViewModel, to view: CharacterView) {
        super.bind(viewModel: viewModel, to: view)
        
        view.searchBar
            .rx.text.orEmpty
            .filter { $0.count != 0 }
            .throttle(.milliseconds(600), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .bind(to: viewModel.searchText)
            .disposed(by: disposeBag)
        
        viewModel.characters
            .map { [SectionModel(model: "Heroes of Marvel", items: $0)] }
            .subscribeOn(MainScheduler.instance)
            .bind(to: view.tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
    }

    
}
