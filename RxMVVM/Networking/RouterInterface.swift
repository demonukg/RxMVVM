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
    
    func asURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue("", forHTTPHeaderField: "Authorization")
        return try encoding.encode(urlRequest, with: params)
    }
}
