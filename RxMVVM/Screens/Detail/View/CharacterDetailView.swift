//
//  CharacterDetailView.swift
//  RxMVVM
//
//  Created by Dmitry Y. on 4/23/20.
//  Copyright © 2020 Dmitry Y. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

final class CharacterDetailView: MVVMView {
    
    var character: Character! {
        didSet {
            characterImageView.image = nil
            if let url = character.thumbnail.url {
                characterImageView.af.setImage(withURL: url)
            }
        }
    }
    
    private let characterImageView = UIImageView()
    
    override func addSubviews() {
        super.addSubviews()
        
        addSubview(characterImageView)
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        
        characterImageView.snp.makeConstraints {
            $0.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
}
