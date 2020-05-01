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
            activityIndicator.startAnimating()
            comicsImageView.image = nil
            if let url = comics.thumbnail.url {
                comicsImageView.af.setImage(withURL: url) { _ in
                    self.activityIndicator.stopAnimating()
                }
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
    
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    override func addSubviews() {
        super.addSubviews()
        
        addSubview(comicsImageView)
        comicsImageView.addFullSubview(activityIndicator)
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        
        comicsImageView.snp.makeConstraints {
            $0.edges.equalTo(self)
        }
    }
    
}
