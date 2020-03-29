//
//  TrackTableViewCell.swift
//  RxMVVM
//
//  Created by Dmitry Y. on 3/28/20.
//  Copyright © 2020 Dmitry Y. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

final class TrackTableViewCell: MVVMTableViewCell {
    
    static let reuseId: String = "TrackTableViewCell"
    
    var track: (String, String)! {
        didSet {
            guard let (image, name) = track else { return }
            trackImageView.image = UIImage(named: image)
            trackNameLabel.text = name
        }
    }
    
    private let trackImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let trackNameLabel = UILabel()
    
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
        
        stackView.addArrangedSubview(trackImageView)
        stackView.addArrangedSubview(trackNameLabel)
        addSubview(stackView)
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        
        trackImageView.snp.makeConstraints {
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
