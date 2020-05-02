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
                        observer.onError(error)
                    }
                }
            }
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
    static func request<T: Decodable>(_ urlRequest: URLRequestConvertible,
                                      result: @escaping(Swift.Result<T, Error>) -> Void) {
        AF.request(urlRequest).responseData { (response) in
            switch response.result {
            case .success(let data):
                
                do {
                    let decoder = JSONDecoder()
                    let object = try decoder.decode(T.self, from: data)
                    result(.success(object))
                    return
                } catch {
                    let nserror = error as NSError
                    let messages = [
                        nserror.localizedDescription,
                        nserror.localizedFailureReason,
                        nserror.localizedRecoverySuggestion
                    ]
                    let message = messages.compactMap({ $0 }).joined(separator: "\n")
                    result(.failure(.decoding(description: message)))
                }
                
            case .failure(let error):
                result(.failure(.descripted(code: response.response?.statusCode, description: error.localizedDescription)))
                
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
        
        case decoding(description: String)
        
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
        case let .decoding(description):
            return "Data parsing failure" + "\n" + description
            
        case let .descripted(code, description):
            return "An error was found" + "\n" + "Code" + ": " + "\(String(describing: code))" + "\n" + "Description" + ": " + description
        }
    }
    
}
