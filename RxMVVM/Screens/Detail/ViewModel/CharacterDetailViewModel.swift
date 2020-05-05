//
//  CharacterDetailViewModel.swift
//  RxMVVM
//
//  Created by Dmitry Y. on 4/23/20.
//  Copyright © 2020 Dmitry Y. All rights reserved.
//

import Foundation
import Foundation
import RxSwift
import RxRelay
import RxCocoa

protocol CharacterDetailViewModelInterface: MVVMViewModelInterface {
    
    var comics: Driver<[Comics]> { get }
    var isLoading: Driver<Bool> { get }
    var error: Driver<MainError> { get }
    
    var reachedEdge: PublishRelay<Void> { get }
    var characterId: BehaviorRelay<Int> { get }
    
}

final class CharacterDetailViewModel: MVVMViewModel, CharacterDetailViewModelInterface {

    var comics: Driver<[Comics]> { comicsRelay.asDriver(onErrorJustReturn: []) }
    var isLoading: Driver<Bool> { isLoadingRelay.asDriver() }
    var error: Driver<MainError> { errorRelay.asDriver(onErrorJustReturn: .internalError("unknown")) }
    
    let reachedEdge = PublishRelay<Void>()
    let characterId = BehaviorRelay<Int>(value: 0)
    
    private let comicsRelay = BehaviorRelay<[Comics]>(value: [])
    private let isLoadingRelay = BehaviorRelay<Bool>(value: false)
    private let errorRelay = PublishRelay<MainError>()
    
    private let comicsRequest = BehaviorRelay<CharacterRouter>(value: CharacterRouter.getCharacterComics(characterId: 0))
    private var currentId: Int = 0
    
    private let networkService: NetworkingInterface
    
    
    init(networkService: NetworkingInterface) {
        self.networkService = networkService
        
        super.init()
    }
    
    override func onBind() {
        super .onBind()
        
        let newComicsRequest = characterId
            .filter { $0 != 0}
            .do(onNext: { (id) in self.currentId = id })
            .withLatestFrom(comicsRequest) { id,_ in CharacterRouter.getCharacterComics(characterId: id)}
        
        newComicsRequest
            .map {_ in []}
            .bind(to: comicsRelay)
            .disposed(by: disposeBag)
        
        let allComicsRequest = Observable.merge(
            newComicsRequest,
            reachedEdge
                .withLatestFrom(comicsRequest) { _,_ in CharacterRouter.getCharacterComics(characterId: self.currentId, offset: self.comicsRelay.value.count)}
                .share()
        )
        
        allComicsRequest
            .bind(to: comicsRequest)
            .disposed(by: disposeBag)
        
        allComicsRequest
            .map {_ in true }
            .bind(to: isLoadingRelay)
            .disposed(by: disposeBag)
        
        let comicsResponse: Observable<GetComicsResponse> = allComicsRequest
            .flatMapLatest { [networkService] in
                networkService.requestRx($0)
        }.share()
        
        comicsResponse
            .map {_ in false}
            .catchErrorJustReturn(false)
            .bind(to: isLoadingRelay)
            .disposed(by: disposeBag)
        
        comicsResponse
            .map { $0.data.results }
            .catchErrorJustReturn([])
            .withLatestFrom(comicsRelay) { $1 + $0 }
            .bind(to: comicsRelay)
            .disposed(by: disposeBag)
        
        comicsResponse
            .subscribe(onError: { self.errorRelay.accept(.serverError($0)) })
            .disposed(by: disposeBag)
        
    }
    
}
