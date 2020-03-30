//
//  Album.swift
//  RxMVVM
//
//  Created by Dmitry Y. on 3/29/20.
//  Copyright © 2020 Dmitry Y. All rights reserved.
//

import Foundation

struct Album: Decodable {
    
    let id: String
    
    let name: String
    
    let albumArtWork: String
    
    let artist: String
    
    private enum CodingKeys: String, CodingKey {
        
        case id
        
        case name
        
        case albumArtWork = "album_art_work"
        
        case artist
        
    }
    
}
