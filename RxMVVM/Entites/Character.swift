//
//  Character.swift
//  RxMVVM
//
//  Created by Dmitry Y. on 3/30/20.
//  Copyright © 2020 Dmitry Y. All rights reserved.
//

import Foundation

struct Character: Decodable {
    
    let id: String
    
    let name: String
    
    let description: String
    
    let thumbnail: Thumbnail
    
    enum CodingKeys: String, CodingKey {
        
        case id
        
        case name
        
        case description
        
        case thumbnail
        
    }
}
