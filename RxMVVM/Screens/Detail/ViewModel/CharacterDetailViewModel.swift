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
    
    var shouldLoadNextPage: Bool { get set }
}

final class CharacterDetailViewModel: MVVMViewModel, CharacterDetailViewModelInterface {
    
    let loadNextPageTrigger: PublishSubject<Void> = PublishSubject()
    
    let error: PublishSubject<MainError> = PublishSubject()
    
    let comics: BehaviorSubject<[Comics]> = BehaviorSubject(value: [])
    
    let characterId: BehaviorSubject<Int> = BehaviorSubject(value: 0)
    
    var shouldLoadNextPage: Bool = false
    
    private var currentId: Int = 0
    
    override func onBind() {
        super .onBind()
        
        characterId
            .subscribe(onNext: { id in
                self.currentId = id
                self.makeRequest(id)
            }).disposed(by: disposeBag)
    }
    
    func makeRequest(_ id: Int) {
        getCharacterComics(id: id)
            .subscribe(onNext: { comics in
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
    
    func getCharacterComics(id: Int, limit: Int? = 20, offset: Int? = nil) -> Observable<GetComicsResponse> {
        return Networking.requestRx(CharacterRouter.getCharacterComics(characterId: id, limit: limit, offset: offset))
    }
    
}
