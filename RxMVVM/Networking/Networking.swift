//
//  Networking.swift
//  RxMVVM
//
//  Created by Dmitry Y. on 3/30/20.
//  Copyright © 2020 Dmitry Y. All rights reserved.
//

import Alamofire

final class Networking {
    
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

        case decoding(description: String)
        
        case descripted(code: Int?, description: String)
        
    }
    
}

extension Networking.Error: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case let .decoding(description):
            return "Data parsing failure" + "\n" + description
            
        case let .descripted(code, description):
            return "An error was found" + "\n" + "Code" + ": " + "\(String(describing: code))" + "\n" + "Description" + ": " + description
        }
    }
    
}
