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
import Swinject

typealias CharactersController = UIViewController & CharactersViewControllerInterface

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
    
    override func contentViewDidLoad(_ view: ContentView) {
        super.contentViewDidLoad(view)
        
        navigationItem.title = "Heroes of Marvel"
    }
    
    override func bind(view: CharacterView) {
        super.bind(view: view)
        
        //TODO: - asDriver?
        view.searchBar
            .rx.searchButtonClicked
            .asDriver().drive(onNext: { _ in
                view.searchBar.endEditing(true)
            }).disposed(by: disposeBag)
        
        view.tableView
            .rx.modelSelected(Character.self)
            .subscribe(onNext: { (character) in
                self.navigationController?.pushViewController(Assembler.shared.resolver.resolve(CharacterDetailController.self, argument: character)!, animated: true)
                if let index = view.tableView.indexPathForSelectedRow{
                    view.tableView.deselectRow(at: index, animated: true)
                }
            }).disposed(by: disposeBag)
        
    }
    
    override func bind(viewModel: ViewModel) {
        super.bind(viewModel: viewModel)
        
        viewModel.error
            .drive(onNext: { (error) in
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
            .bind(to: viewModel.search)
            .disposed(by: disposeBag)
        
        view.tableView
            .rx.reachedBottom(offset: 100.0)
            .bind(to: viewModel.reachedBottom)
            .disposed(by: disposeBag)
        
        viewModel.characters
            .map { [SectionModel(model: "Heroes of Marvel", items: $0)] }
            .drive(view.tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        viewModel.isLoading
            .drive(view.activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
        
    }

    
}
