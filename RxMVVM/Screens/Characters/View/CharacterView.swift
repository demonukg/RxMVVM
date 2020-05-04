//
//  CharacterView.swift
//  RxMVVM
//
//  Created by Dmitry Y. on 4/23/20.
//  Copyright © 2020 Dmitry Y. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

final class CharacterView: MVVMView {
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CharacterTableViewCell.self, forCellReuseIdentifier: CharacterTableViewCell.reuseId)
        tableView.rowHeight = 70.0
        tableView.keyboardDismissMode = .onDrag
        return tableView
    }()
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .minimal
        searchBar.returnKeyType = .done
        searchBar.placeholder = "Enter a name like Spider-Man..."
        searchBar.sizeToFit()
        return searchBar
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        return activityIndicator
    }()
    
    override func addSubviews() {
        super.addSubviews()
        
        addSubview(tableView)
        tableView.tableHeaderView = searchBar
        tableView.tableFooterView = activityIndicator
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        
        tableView.snp.makeConstraints {
            $0.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
}
