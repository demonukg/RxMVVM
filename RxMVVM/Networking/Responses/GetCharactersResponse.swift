//
//  GetCharactersResponse.swift
//  RxMVVM
//
//  Created by Dmitry Y. on 4/25/20.
//  Copyright © 2020 Dmitry Y. All rights reserved.
//

import Foundation

struct GetCharactersResponse: Decodable {
    
    let status: String
    
    let data: ComicsData
    
    enum CodingKeys: String, CodingKey {
        
        case status
        
        case data
        
    }
    
}

extension GetCharactersResponse {
    
    struct ComicsData: Decodable {
        
        let results: [Character]
        
        enum CodingKeys: String, CodingKey {
            
            case results
            
        }
    }
}

