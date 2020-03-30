//
//  Thumbnail.swift
//  RxMVVM
//
//  Created by Dmitry Y. on 3/30/20.
//  Copyright © 2020 Dmitry Y. All rights reserved.
//

import Foundation

struct Thumbnail: Decodable {
    
    let path: String
    
    let ext: String
    
    enum CodingKeys: String, CodingKey {
        
        case path
        
        case ext = "extension"
        
    }
}
