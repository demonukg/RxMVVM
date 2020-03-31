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
    
    var albums: PublishSubject<[Comics]> { get }
    
    var track: PublishSubject<[Character]> { get }
    
    var loading: PublishSubject<Bool> { get set }
    
    var error: PublishSubject<MainError> { get set }
    
}

final class BaseViewModel: MVVMViewModel, BaseViewModelInterface {
    
    let albums: PublishSubject<[Comics]> = PublishSubject()
    
    let track: PublishSubject<[Character]> = PublishSubject()
    
    var loading: PublishSubject<Bool> = PublishSubject()
    
    var error: PublishSubject<MainError> = PublishSubject()
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        getComics { comics in
            switch comics {
            case .success(let comics):
                print(comics.count)
            case .failure(let error):
                print(error.localizedDescription)
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
