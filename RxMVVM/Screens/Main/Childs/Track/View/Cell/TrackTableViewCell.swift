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
    
    let trackImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let trackNameLabel = UILabel()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
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
            $0.height.equalTo(50)
        }
        
        stackView.snp.makeConstraints {
            $0.edges.equalTo(self).offset(-10)
        }
        
    }
    
}
