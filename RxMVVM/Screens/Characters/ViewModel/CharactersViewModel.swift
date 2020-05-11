//
//  CharactersViewModel.swift
//  RxMVVM
//
//  Created by Dmitry Y. on 4/23/20.
//  Copyright © 2020 Dmitry Y. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay
import RxCocoa

protocol CharactersViewModelInterface: MVVMViewModelInterface {
    
    var characters: Driver<[Character]> { get }
    var isLoading: Driver<Bool> { get }
    var error: Driver<MainError> { get }
    
    var reachedBottom: PublishRelay<Void> { get }
    var search: PublishRelay<String> { get }
    
}

final class CharactersViewModel: MVVMViewModel, CharactersViewModelInterface {
    
    var characters: Driver<[Character]> { charactersRelay.asDriver(onErrorJustReturn: []) }
    var isLoading: Driver<Bool> { isLoadingRelay.asDriver() }
    var error: Driver<MainError> { errorRelay.asDriver(onErrorJustReturn: .internalError("unknown")) }
    
    let reachedBottom = PublishRelay<Void>()
    let search = PublishRelay<String>()
    
    private let charactersRelay = BehaviorRelay<[Character]>(value: [])
    private let isLoadingRelay = BehaviorRelay<Bool>(value: false)
    private let errorRelay = PublishRelay<MainError>()
    
    private let searchRequest = BehaviorRelay<CharacterRouter>(value: CharacterRouter.getCharacters(name: ""))
    private var currentText: String = ""
    
    private let networkService: NetworkingInterface
    
    
    init(networkService: NetworkingInterface) {
        self.networkService = networkService
        
        super.init()
    }
    
    override func onBind() {
        super .onBind()
        
        let newSearchRequests = search
            .filter { !$0.isEmpty }
            .distinctUntilChanged()
            .debounce(.seconds(1), scheduler: MainScheduler.instance)
            .do(onNext: { query in self.currentText = query })
            .withLatestFrom(searchRequest) { query, _ in CharacterRouter.getCharacters(name: query) }
            .share()
        
        newSearchRequests
            .map {_ in []}
            .bind(to: charactersRelay)
            .disposed(by: disposeBag)
        
        let allSearchRequests = Observable.merge(
            newSearchRequests,
            reachedBottom
                .filter { !self.currentText.isEmpty }
                .withLatestFrom(searchRequest) { _,_ in CharacterRouter.getCharacters(name: self.currentText, offset: self.charactersRelay.value.count) }
                .share()
        ).share()
        
        allSearchRequests
            .bind(to: searchRequest)
            .disposed(by: disposeBag)
        
        allSearchRequests
            .map {_ in true}
            .bind(to: isLoadingRelay)
            .disposed(by: disposeBag)
        
        let searchResponse: Observable<GetCharactersResponse> = allSearchRequests
            .flatMapLatest { [networkService] in
                networkService.requestRx($0)
        }.share()
        
        searchResponse
            .map {_ in false}
            .catchErrorJustReturn(false)
            .bind(to: isLoadingRelay)
            .disposed(by: disposeBag)
        
        searchResponse
            .map { $0.data.results }
            .catchErrorJustReturn([])
            .withLatestFrom(charactersRelay) { $1 + $0 }
            .bind(to: charactersRelay)
            .disposed(by: disposeBag)
        
        searchResponse
            .subscribe(onError: { self.errorRelay.accept(.serverError($0)) })
            .disposed(by: disposeBag)
    }
}
