//
//  HeroesView.swift
//  RxMVVM
//
//  Created by Dmitry Y. on 4/23/20.
//  Copyright © 2020 Dmitry Y. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

final class CharacterView: MVVMView {
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .minimal
        searchBar.sizeToFit()
        return searchBar
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CharacterTableViewCell.self, forCellReuseIdentifier: CharacterTableViewCell.reuseId)
        return tableView
    }()
    
    
    override func addSubviews() {
        super.addSubviews()
        
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        
    }
}
