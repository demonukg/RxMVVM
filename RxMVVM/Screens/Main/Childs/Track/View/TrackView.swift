//
//  TrackView.swift
//  RxMVVM
//
//  Created by Dmitry Y. on 3/28/20.
//  Copyright © 2020 Dmitry Y. All rights reserved.
//

import Foundation
import SnapKit
import UIKit

final class TrackView: MVVMView {
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 70.0
        tableView.register(TrackTableViewCell.self, forCellReuseIdentifier: TrackTableViewCell.reuseId)
        return tableView
    }()

    override func addSubviews() {
        super.addSubviews()
        addSubview(tableView)
    }

    override func makeConstraints() {
        super.makeConstraints()

        tableView.snp.makeConstraints {
            $0.edges.equalTo(self)
        }
    }
    
}
