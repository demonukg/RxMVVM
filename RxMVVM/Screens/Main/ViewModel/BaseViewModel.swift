//
//  BaseViewModel.swift
//  RxMVVM
//
//  Created by Dmitry Y. on 3/28/20.
//  Copyright © 2020 Dmitry Y. All rights reserved.
//

import Foundation
import RxSwift

protocol BaseViewModelInterface {
    
    var comics: PublishSubject<[Comics]> { get }
    
    var characters: PublishSubject<[Character]> { get }
    
    var loading: PublishSubject<Bool> { get set }
    
    var error: PublishSubject<MainError> { get set }
    
    var loadNextPageTrigger: PublishSubject<Void> { get set }
    
}

final class BaseViewModel: MVVMViewModel, BaseViewModelInterface {
    
    let comics: PublishSubject<[Comics]> = PublishSubject()
    
    let characters: PublishSubject<[Character]> = PublishSubject()
    
    var loading: PublishSubject<Bool> = PublishSubject()
    
    var error: PublishSubject<MainError> = PublishSubject()
    
    var loadNextPageTrigger = PublishSubject<Void>()
    
    override func onBind() {
        super .onBind()
        
        willAppear.subscribe { [weak self] _ in
            self?.makeRequest()
        }.disposed(by: disposeBag)
        
        loadNextPageTrigger
            .subscribe {
            print("loadNextPageTrigger")
        }.disposed(by: disposeBag)
    }
    
    func makeRequest() {
        loading.onNext(true)
        
        getComicsRx()
            .subscribeOn(MainScheduler.instance)
            .do(onDispose: {
                self.loading.onNext(false)
            }).subscribe(onNext: { comics in
                self.comics.onNext(comics.data.results)
            }, onError: { error in
                self.error.onNext(.serverError(error))
            }).disposed(by: disposeBag)
    }
}

//MARK: - Requests

private extension BaseViewModel {
    
    func getComics(limit: Int? = 10,
                   offset: Int? = nil,
                   completion: @escaping (Result<[Comics], Error>) -> Void) {
        let request = ComicsRouter.getComics(limit: limit, offset: offset)
        Networking.request(request) { (result: Result<GetComicsResponse, Networking.Error>) in
            switch result {
            case .success(let response):
                completion(.success(response.data.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
    func getComicsRx(limit: Int? = 10, offset: Int? = nil) -> Observable<GetComicsResponse> {
        return Networking.requestRx(ComicsRouter.getComics(limit: limit, offset: offset))
    }
    
    
    
}
