//
//  CharacterRouter.swift
//  RxMVVM
//
//  Created by Dmitry Y. on 3/30/20.
//  Copyright © 2020 Dmitry Y. All rights reserved.
//

import Foundation
import Alamofire

enum CharacterRouter  {
    
    case getCharacter(characterId: Int)
    
    case getCharacters(name: String, limit: Int? = 20, offset: Int? = nil)
    
    case getCharacterComics(characterId: Int, limit: Int?, offset: Int?)
}

extension CharacterRouter: RouterInterface {
    
    var method: HTTPMethod {
        switch self {
        case .getCharacter, .getCharacters, .getCharacterComics:
            return .get
        }
    }
    
    var params: [String : Any] {
        switch self {
        case .getCharacter:
            let params = [String: Any]()
            return params
        case let .getCharacters(name, limit, offset):
            var params = [String: Any]()
            params["nameStartsWith"] = name
            params["limit"] = limit
            params["offset"] = offset
            return params
        case let .getCharacterComics(_, limit, offset):
            var params = [String: Any]()
            params["limit"] = limit
            params["offset"] = offset
            return params
        }
    }
    
    var url: URL {
        let relativePath: String
        switch self {
        case .getCharacter(let characterId):
            relativePath = "/v1/public/characters/\(characterId)"
        case .getCharacters:
            relativePath = "/v1/public/characters"
        case let .getCharacterComics(characterId, _, _):
            relativePath = "/v1/public/characters/\(characterId)/comics"
        }
        return Constants.baseURL.appendingPathComponent(relativePath)
    }
}
