//
//  CharactersViewModel.swift
//  RxMVVM
//
//  Created by Dmitry Y. on 4/23/20.
//  Copyright © 2020 Dmitry Y. All rights reserved.
//

import Foundation
import RxSwift

protocol CharactersViewModelInterface: MVVMViewModelInterface {
    
    var searchText: PublishSubject<String> { get }
    
    var characters: BehaviorSubject<[Character]> { get }
    
    var loadNextPageTrigger: PublishSubject<Void> { get }
    
    var error: PublishSubject<MainError> { get }
    
    var shouldLoadNextPage: Bool { get set }
    
}

final class CharactersViewModel: MVVMViewModel, CharactersViewModelInterface {
    
    let loadNextPageTrigger: PublishSubject<Void> = PublishSubject()
    
    let error: PublishSubject<MainError> = PublishSubject()
    
    let searchText: PublishSubject<String> = PublishSubject()
    
    let characters: BehaviorSubject<[Character]> = BehaviorSubject(value: [])
    
    var shouldLoadNextPage: Bool = false
    
    private var currentText: String = ""
    
    private let networkService: NetworkingInterface
    
    init(networkService: NetworkingInterface) {
        self.networkService = networkService
        
        super.init()
    }
    
    override func onBind() {
        super .onBind()
        
        searchText
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .userInteractive))
            .subscribe(onNext: { (text) in
                self.makeRequest(name: text)
            }).disposed(by: disposeBag)
        
        loadNextPageTrigger
            .subscribe(onNext: { _ in
                self.shouldLoadNextPage = false
                self.makePaginationRequest()
            }).disposed(by: disposeBag)
        
    }
    
    func makeRequest(name: String) {
        currentText = name
        getCharacters(name: name)
            .subscribe(onNext: { characters in
                self.shouldLoadNextPage = true
                self.characters.onNext(characters.data.results)
            }, onError: { error in
                self.error.onNext(.serverError(error))
            }).disposed(by: disposeBag)
    }
    
    func makePaginationRequest() {
        do {
            getCharacters(name: currentText, offset: try characters.value().count)
            .subscribe(onNext: { response in
                self.shouldLoadNextPage = response.data.count == 0 ? false : true
                try? self.characters.onNext(self.characters.value() + response.data.results)
            }, onError: { error in
                self.error.onNext(.serverError(error))
            }).disposed(by: disposeBag)
        } catch {
            self.error.onNext(.internalError(error.localizedDescription))
        }
    }
}

//MARK: - Requests

private extension CharactersViewModel {
    
    func getCharacters(name: String, limit: Int? = 20, offset: Int? = nil) -> Observable<GetCharactersResponse> {
        return networkService.requestRx(CharacterRouter.getCharacters(name: name, limit: limit, offset: offset))
    }
    
}
