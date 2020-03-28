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
    
    let albumImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let albumNameLabel = UILabel()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
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
