//
//  Track.swift
//  RxMVVM
//
//  Created by Dmitry Y. on 3/29/20.
//  Copyright © 2020 Dmitry Y. All rights reserved.
//

import Foundation

struct Track: Decodable {
    
    let id: String
    
    let name: String
    
    let trackArtWork: String
    
    let trackAlbum: String
    
    let artist: String
    
    enum CodingKeys: String, CodingKey {
        
        case id
        
        case name
        
        case trackArtWork = "track_art_work"
        
        case trackAlbum = "track_album"
        
        case artist
        
    }
}
