//
//  AlbumView.swift
//  RxMVVM
//
//  Created by Dmitry Y. on 3/28/20.
//  Copyright © 2020 Dmitry Y. All rights reserved.
//

import Foundation
import SnapKit
import UIKit

final class AlbumView: MVVMView {
    
    let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        let layout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = UICollectionView.ScrollDirection.vertical
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.register(AlbumCollectionViewCell.self, forCellWithReuseIdentifier: AlbumCollectionViewCell.reuseId)
        return collectionView
    }()

    override func addSubviews() {
        super.addSubviews()
        addSubview(collectionView)
    }

    override func makeConstraints() {
        super.makeConstraints()

        collectionView.snp.makeConstraints {
            $0.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
}
