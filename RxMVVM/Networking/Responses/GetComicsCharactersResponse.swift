//
//  GetComicsCharactersResponse.swift
//  RxMVVM
//
//  Created by Dmitry Y. on 3/30/20.
//  Copyright © 2020 Dmitry Y. All rights reserved.
//

import Foundation

struct GetComicsCharactersResponse: Decodable {
    
    let success: String
    
    let results: [Character]
    
    enum CodingKeys: String, CodingKey {
        
        case success
        
        case results
        
    }
    
}
