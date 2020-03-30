//
//  ComicsRouter.swift
//  RxMVVM
//
//  Created by Dmitry Y. on 3/30/20.
//  Copyright © 2020 Dmitry Y. All rights reserved.
//

import Foundation
import Alamofire

enum ComicsRouter  {
    
    case getComics(limit: Int?, offset: Int?)
    
    case getCharacters(comicId: Int, limit: Int?, offset: Int?)
    
}

extension ComicsRouter: RouterInterface {
    
    var method: HTTPMethod {
        switch self {
        case .getComics, .getCharacters:
            return .get
        }
    }
    
    var params: [String : Any] {
        switch self {
        case let .getComics(limit, offset):
            var params = [String: Any]()
            params["limit"] = limit
            params["offset"] = offset
            return params
        case let .getCharacters(comicId, limit, offset):
            var params = [String: Any]()
            params["comicId"] = comicId
            params["limit"] = limit
            params["offset"] = offset
            return params
        }
    }
    
    var url: URL {
        let relativePath: String
        switch self {
        case .getComics:
            relativePath = "/v1/public/comics"
        case .getCharacters(let comicId, _, _):
            relativePath = "/v1/public/comics/\(comicId)/characters"
        }
        return Constants.baseURL.appendingPathComponent(relativePath)
    }
}
