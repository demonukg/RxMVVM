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
    
    var characters: PublishSubject<[Character]> { get }
    
    var error: PublishSubject<MainError> { get }
    
}

final class CharactersViewModel: MVVMViewModel, CharactersViewModelInterface {
    
    let error: PublishSubject<MainError> = PublishSubject()
    
    let searchText: PublishSubject<String> = PublishSubject()
    
    var characters: PublishSubject<[Character]> = PublishSubject()
    
    override func onBind() {
        super .onBind()
        
        searchText.subscribe(onNext: { (text) in
            self.makeRequest(name: text)
            }).disposed(by: disposeBag)
        
    }
    
    func makeRequest(name: String) {
        getCharacters(name: name)
            .subscribe(onNext: { characters in
                self.characters.onNext(characters.data.results)
            }, onError: { error in
                self.error.onNext(.serverError(error))
            }).disposed(by: disposeBag)
    }
}

//MARK: - Requests

private extension CharactersViewModel {
    
    func getCharacters(name: String, limit: Int? = 10, offset: Int? = nil) -> Observable<GetCharactersResponse> {
        return Networking.requestRx(CharacterRouter.getCharacters(name: name, limit: limit, offset: offset))
    }
    
}
