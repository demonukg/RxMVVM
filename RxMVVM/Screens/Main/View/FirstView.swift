//
//  FirstView.swift
//  RxMVVM
//
//  Created by Dmitry Y. on 3/28/20.
//  Copyright © 2020 Dmitry Y. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

final class FirstView: MVVMView {
    
    let albumContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        return view
    }()
    
    let trackContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .yellow
        return view
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    
    required init() {
        super.init()
        backgroundColor = .white
    }
    
    override func addSubviews() {
        super.addSubviews()
        stackView.addArrangedSubview(albumContainerView)
        stackView.addArrangedSubview(trackContainerView)
        self.addSubview(stackView)
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        
        albumContainerView.snp.makeConstraints {
            $0.height.equalTo(100)
        }
        
        stackView.snp.makeConstraints {
            $0.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    func addAlbumView(_ view: UIView) {
        albumContainerView.addFullSubview(view)
    }
    
    func addTrackView(_ view: UIView) {
        trackContainerView.addFullSubview(view)
    }
}
