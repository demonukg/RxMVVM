//
//  Comics.swift
//  RxMVVM
//
//  Created by Dmitry Y. on 3/30/20.
//  Copyright © 2020 Dmitry Y. All rights reserved.
//

import Foundation

struct Comics: Decodable {
    
    let id: Int
    
    let title: String
    
    let thumbnail: Thumbnail
    
    
    enum CodingKeys: String, CodingKey {
        
        case id
        
        case title
        
        case thumbnail
        
    }
}
