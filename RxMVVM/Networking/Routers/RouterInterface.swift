//
//  RouterInterface.swift
//  RxMVVM
//
//  Created by Dmitry Y. on 3/30/20.
//  Copyright © 2020 Dmitry Y. All rights reserved.
//

import Foundation
import Foundation
import Alamofire
import CryptoKit

protocol RouterInterface: URLRequestConvertible {
    
    var method: HTTPMethod { get }
    
    var params: [String: Any] { get }

    var url: URL { get }
    
    var encoding: ParameterEncoding { get }
}

extension RouterInterface {
    
    var encoding: ParameterEncoding {
        return method.defaultEncoding
    }
    
    var ts: String {
        return "1"
    }
    
    var finalParams: [String: Any] {
        var finalParams = params
        finalParams["apikey"] = Constants.apikey
        finalParams["ts"] = ts
        finalParams["hash"] = MD5(string: ts+Constants.privateKey+Constants.apikey)
        return finalParams
    }
    
    func asURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        return try encoding.encode(urlRequest, with: finalParams)
    }
    
}

private extension RouterInterface {
    
    func MD5(string: String) -> String {
        let digest = Insecure.MD5.hash(data: string.data(using: .utf8) ?? Data())

        return digest.map {
            String(format: "%02hhx", $0)
        }.joined()
    }
    
}
