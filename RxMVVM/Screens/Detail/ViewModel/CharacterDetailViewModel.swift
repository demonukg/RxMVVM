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

protocol CharacterDetailViewModelInterface: MVVMViewModelInterface {
    
    var loadNextPageTrigger: PublishSubject<Void> { get }
    
    var error: PublishSubject<MainError> { get }
    
    var characterId: BehaviorSubject<Int> { get }
    
    var comics: BehaviorSubject<[Comics]> { get }
    
    var loading: PublishSubject<Bool> { get }
    
    var shouldLoadNextPage: Bool { get set }
    
}

final class CharacterDetailViewModel: MVVMViewModel, CharacterDetailViewModelInterface {
    
    let loadNextPageTrigger: PublishSubject<Void> = PublishSubject()
    
    let error: PublishSubject<MainError> = PublishSubject()
    
    let comics: BehaviorSubject<[Comics]> = BehaviorSubject(value: [])
    
    let characterId: BehaviorSubject<Int> = BehaviorSubject(value: 0)
    
    let loading: PublishSubject<Bool> = PublishSubject()
    
    var shouldLoadNextPage: Bool = false
    
    private var currentId: Int = 0
    
    private let networkService: NetworkingInterface
    
    init(networkService: NetworkingInterface) {
        self.networkService = networkService
        
        super.init()
    }
    
    override func onBind() {
        super .onBind()
        
        characterId
            .filter { $0 != 0}
            .subscribe(onNext: { id in
                self.currentId = id
                self.makeRequest(id)
            }).disposed(by: disposeBag)
        
        loadNextPageTrigger
        .subscribe(onNext: { _ in
            self.shouldLoadNextPage = false
            self.makePaginationRequest()
        }).disposed(by: disposeBag)
    }
    
    func makeRequest(_ id: Int) {
        loading.onNext(true)
        getCharacterComics(id: id)
            .do(onDispose: {
                self.loading.onNext(false)
            }).subscribe(onNext: { comics in
                self.shouldLoadNextPage = true
                self.comics.onNext(comics.data.results)
            }, onError: { error in
                self.error.onNext(.serverError(error))
            }).disposed(by: disposeBag)
    }
    
    func makePaginationRequest() {
        do {
            getCharacterComics(id: currentId, offset: try comics.value().count)
            .subscribe(onNext: { response in
                self.shouldLoadNextPage = response.data.count == 0 ? false : true
                try? self.comics.onNext(self.comics.value() + response.data.results)
            }, onError: { error in
                self.error.onNext(.serverError(error))
            }).disposed(by: disposeBag)
        } catch {
            self.error.onNext(.internalError(error.localizedDescription))
        }
    }
    
}

//MARK: - Requests

private extension CharacterDetailViewModel {
    
    func getCharacterComics(id: Int, limit: Int? = 5, offset: Int? = nil) -> Observable<GetComicsResponse> {
        return networkService.requestRx(CharacterRouter.getCharacterComics(characterId: id, limit: limit, offset: offset))
    }
    
}
