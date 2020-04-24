//
//  CharacterTableViewCell.swift
//  RxMVVM
//
//  Created by Dmitry Y. on 4/24/20.
//  Copyright © 2020 Dmitry Y. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

final class CharacterTableViewCell: MVVMTableViewCell {
    
    static let reuseId: String = "CharacterTableViewCell"
    
    var character: Character! {
        didSet {
            guard let character = character else { return }
            if let url = character.thumbnail.url {
                characterImageView.af.setImage(withURL: url)
            }
            characterNameLabel.text = character.name
        }
    }
    
    private let characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let characterNameLabel = UILabel()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 10
        return stackView
    }()
    
    override func addSubviews() {
        super.addSubviews()
        
        stackView.addArrangedSubview(characterImageView)
        stackView.addArrangedSubview(characterNameLabel)
        addSubview(stackView)
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        
        characterImageView.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.width.equalTo(50)
        }
        
        stackView.snp.makeConstraints {
            $0.leading.equalTo(self.snp.leading).offset(10)
            $0.trailing.equalTo(self.snp.trailing).offset(-10)
            $0.top.equalTo(self.snp.top).offset(10)
            $0.bottom.equalTo(self.snp.bottom).offset(-10)
        }
        
    }
    
}
