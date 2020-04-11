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
    
}

final class BaseViewModel: MVVMViewModel, BaseViewModelInterface {
    
    let comics: PublishSubject<[Comics]> = PublishSubject()
    
    let characters: PublishSubject<[Character]> = PublishSubject()
    
    var loading: PublishSubject<Bool> = PublishSubject()
    
    var error: PublishSubject<MainError> = PublishSubject()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        loading.onNext(true)
        
        getComicsRx()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { comics in
                self.comics.onNext(comics.data.results)
                self.loading.onNext(false)
            }, onError: { error in
                self.error.onNext(.serverError(error))
                self.loading.onNext(false)
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
