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
    
}

extension CharacterRouter: RouterInterface {
    
    var method: HTTPMethod {
        switch self {
        case .getCharacter:
            return .get
        }
    }
    
    var params: [String : Any] {
        switch self {
        case  .getCharacter:
            let params = [String: Any]()
            return params
        }
    }
    
    var url: URL {
        let relativePath: String
        switch self {
        case .getCharacter(let characterId):
            relativePath = "/v1/public/characters/\(characterId)"
        }
        return Constants.baseURL.appendingPathComponent(relativePath)
    }
}
