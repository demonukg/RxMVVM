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
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        loading.onNext(true)
        getComics { [weak self] result in
            guard let self = self else { return }
            self.loading.onNext(false)
            switch result {
            case .success(let data):
                self.comics.onNext(data)
            case .failure(let error):
                self.error.onNext(.serverError(error))
            }
        }
        
//        loading.onNext(true)
//        DispatchQueue.main.asyncAfter(deadline: .now()+5) {
//            self.loading.onNext(false)
//            self.error.onNext(.internalError("Hello World"))
//        }
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
    
}
