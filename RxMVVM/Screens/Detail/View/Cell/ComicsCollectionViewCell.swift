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
            comicsImageView.image = nil
            if let url = comics.thumbnail.url {
                comicsImageView.af.setImage(withURL: url)
            }
        }
    }
    
    private let comicsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 5
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let comicsNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
//    private let stackView: UIStackView = {
//        let stackView = UIStackView()
//        stackView.axis = .vertical
//        stackView.alignment = .center
//        stackView.distribution = .fill
//        stackView.spacing = 0.0
//        return stackView
//    }()
    
    override func addSubviews() {
        super.addSubviews()
        
        //stackView.addArrangedSubview(comicsImageView)
        //stackView.addArrangedSubview(comicsNameLabel)
        //addSubview(stackView)
        addSubview(comicsImageView)
        comicsImageView.addSubview(comicsNameLabel)
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        
        comicsImageView.snp.makeConstraints {
            $0.edges.equalTo(self)
        }
        
        comicsNameLabel.snp.makeConstraints {
            $0.centerX.equalTo(comicsImageView.snp.centerX)
            $0.left.top.right.equalTo(comicsImageView).offset(10)
        }
        
    }
    
}
