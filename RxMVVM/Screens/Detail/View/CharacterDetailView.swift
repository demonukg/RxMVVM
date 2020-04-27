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
    
    let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.register(ComicsCollectionViewCell.self, forCellWithReuseIdentifier: ComicsCollectionViewCell.reuseId)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    private let characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let comicsLabel: UILabel = {
        let label = UILabel()
        label.text = "Comics"
        label.font = UIFont.boldSystemFont(ofSize: 24.0)
        return label
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    
    
    override func addSubviews() {
        super.addSubviews()
        
        addSubview(characterImageView)
        addSubview(stackView)
        stackView.addArrangedSubview(comicsLabel)
        stackView.addArrangedSubview(collectionView)
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        
        characterImageView.snp.makeConstraints {
            $0.left.top.right.equalTo(self.safeAreaLayoutGuide)
            $0.height.equalTo(300)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(characterImageView.snp.bottom)
            $0.left.bottom.right.equalTo(self.safeAreaLayoutGuide)
        }
    }
}
