//
//  FirstViewModel.swift
//  RxMVVM
//
//  Created by Dmitry Y. on 3/28/20.
//  Copyright © 2020 Dmitry Y. All rights reserved.
//

import Foundation
import RxSwift

protocol FirstViewModelInterface {
    
    var albums: PublishSubject<Album> { get }
    
    var track: PublishSubject<Track> { get }
    
    var loading: PublishSubject<Bool> { get set }
    
    var error: PublishSubject<MainError> { get set }
    
}

final class FirstViewModel: MVVMViewModel, FirstViewModelInterface {
    
    let albums: PublishSubject<Album> = PublishSubject()
    
    let track: PublishSubject<Track> = PublishSubject()
    
    var loading: PublishSubject<Bool> = PublishSubject()
    
    var error: PublishSubject<MainError> = PublishSubject()
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        loading.onNext(true)
        DispatchQueue.main.asyncAfter(deadline: .now()+5) {
            self.loading.onNext(false)
            self.error.onNext(.internalError("Hello World"))
        }
    }
    
    
    
    
}
