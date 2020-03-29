//
//  AlbumCollectionViewCell.swift
//  RxMVVM
//
//  Created by Dmitry Y. on 3/28/20.
//  Copyright © 2020 Dmitry Y. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

final class AlbumCollectionViewCell: MVVMCollectionViewCell {
    
    static let reuseId: String = "AlbumCollectionViewCell"
    
    var album: (String, String)! {
        didSet {
            guard let (image, name) = album else { return }
            albumImageView.image = UIImage(named: image)
            albumNameLabel.text = name
        }
    }
    
    private let albumImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let albumNameLabel = UILabel()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 0.0
        return stackView
    }()
    
    override func addSubviews() {
        super.addSubviews()
        
        stackView.addArrangedSubview(albumImageView)
        stackView.addArrangedSubview(albumNameLabel)
        addSubview(stackView)
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        
        albumImageView.snp.makeConstraints {
            $0.height.equalTo(100)
            $0.height.equalTo(100)
        }
        
        stackView.snp.makeConstraints {
            $0.edges.equalTo(self)
        }
        
    }
    
}
