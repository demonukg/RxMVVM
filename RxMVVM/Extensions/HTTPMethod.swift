//
//  HTTPMethod.swift
//  RxMVVM
//
//  Created by Dmitry Y. on 3/30/20.
//  Copyright © 2020 Dmitry Y. All rights reserved.
//

import Foundation
import Alamofire

extension HTTPMethod {
    
    var defaultEncoding: ParameterEncoding {
        switch self {
        case .get:
            return URLEncoding.default
        default:
            return JSONEncoding.default
        }
    }
    
}
