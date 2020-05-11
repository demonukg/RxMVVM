//
//  Networking.swift
//  RxMVVM
//
//  Created by Dmitry Y. on 3/30/20.
//  Copyright © 2020 Dmitry Y. All rights reserved.
//

import Alamofire
import RxSwift

protocol NetworkingInterface {
    
    func requestRx<T: Decodable> (_ urlRequest: URLRequestConvertible) -> Observable<T>
    
}

final class Networking: NetworkingInterface {
    
    func requestRx<T: Decodable> (_ urlRequest: URLRequestConvertible) -> Observable<T> {
        return Observable<T>.create { observer in
            let request = AF.request(urlRequest).responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let value):
                    observer.onNext(value)
                    observer.onCompleted()
                case .failure(let error):
                    
                    switch response.response?.statusCode {
                    case 403:
                        observer.onError(Error.forbidden)
                    case 404:
                        observer.onError(Error.notFound)
                    case 409:
                        observer.onError(Error.conflict)
                    case 500:
                        observer.onError(Error.internalServerError)
                    default:
                        observer.onError(Error.descripted(code: response.response?.statusCode, description: error.localizedDescription))
                    }
                }
            }
            return Disposables.create {
                request.cancel()
            }
        }
    }
}

extension Networking {
    
    enum Error: Swift.Error {
        case forbidden
        case notFound
        case conflict
        case internalServerError
        case descripted(code: Int?, description: String)
    }
    
}

extension Networking.Error: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .forbidden:
            return "Status code 403"
        case .notFound:
            return "Status code 404"
        case .conflict:
            return "Status code 409"
        case .internalServerError:
            return "Status code 500"
        case let .descripted(code, description):
            return "An error was found" + "\n" + "Code" + ": " + "\(String(describing: code))" + "\n" + "Description" + ": " + description
        }
    }
    
}
