//
//  BaseView.swift
//  RxMVVM
//
//  Created by Dmitry Y. on 3/28/20.
//  Copyright © 2020 Dmitry Y. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

final class BaseView: MVVMView {
    
    let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.register(ComicsCollectionViewCell.self, forCellWithReuseIdentifier: ComicsCollectionViewCell.reuseId)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    private let comicsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        return view
    }()
    
    private let trackContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .yellow
        return view
    }()
    
    private let stackView: UIStackView = {
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
        self.addSubview(stackView)
        stackView.addArrangedSubview(comicsContainerView)
        stackView.addArrangedSubview(trackContainerView)
        comicsContainerView.addSubview(collectionView)
        
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        
        //проблема тут
        comicsContainerView.snp.makeConstraints {
            $0.height.equalTo(250)
        }
        
        stackView.snp.makeConstraints {
            $0.edges.equalTo(self.safeAreaLayoutGuide)
        }
        
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(comicsContainerView)
        }
        
    }
    
    func addTrackView(_ view: UIView) {
        trackContainerView.addFullSubview(view)
    }
}
