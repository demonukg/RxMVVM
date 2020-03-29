//
//  TrackViewController.swift
//  RxMVVM
//
//  Created by Dmitry Y. on 3/28/20.
//  Copyright © 2020 Dmitry Y. All rights reserved.
//

import Foundation
import UIKit

protocol TrackViewControllerInterface: UIViewController {
    
}

final class TrackViewController<ViewModel: TrackViewModel>: MVVMViewController<TrackView, ViewModel>, TrackViewControllerInterface, UITableViewDataSource, UITableViewDelegate {
    
    override func contentViewDidLoad(_ view: TrackView) {
        super.contentViewDidLoad(view)
        
        view.tableView.delegate = self
        view.tableView.dataSource = self
        
    }
    
    //MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.tracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TrackTableViewCell.reuseId, for: indexPath) as! TrackTableViewCell
        cell.track = viewModel.tracks[indexPath.row]
        return cell
    }
    
    //MARK: - UITableViewDelegate
    
}
