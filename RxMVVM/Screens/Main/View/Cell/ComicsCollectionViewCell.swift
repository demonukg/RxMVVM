//
//  ComicsCollectionViewCell.swift
//  RxMVVM
//
//  Created by Dmitry Y. on 3/28/20.
//  Copyright © 2020 Dmitry Y. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import AlamofireImage

final class ComicsCollectionViewCell: MVVMCollectionViewCell {
    
    static let reuseId: String = "ComicsCollectionViewCell"
    
    var comics: Comics! {
        didSet {
            comicsNameLabel.text = comics.title
            guard let url = URL(string: comics.thumbnail.path + "." + comics.thumbnail.ext) else { return }
            comicsImageView.image = UIImage(named: "ico 400 lp")
        }
    }
    
    private let comicsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 5
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let comicsNameLabel = UILabel()
    
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
        
        stackView.addArrangedSubview(comicsImageView)
        stackView.addArrangedSubview(comicsNameLabel)
        addSubview(stackView)
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        
        comicsImageView.snp.makeConstraints {
            $0.height.equalTo(210)
            $0.height.equalTo(210)
        }
        
        stackView.snp.makeConstraints {
            $0.edges.equalTo(self)
        }
        
    }
    
}
