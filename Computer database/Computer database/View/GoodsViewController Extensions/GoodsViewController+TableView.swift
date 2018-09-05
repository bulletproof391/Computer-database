//
//  GoodsViewController+TableView.swift
//  Computer database
//
//  Created by Дмитрий Вашлаев on 05.09.18.
//  Copyright © 2018 Дмитрий Вашлаев. All rights reserved.
//

import UIKit

extension GoodsViewController {
    
    // MARK: - Table View Data Source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        cell.textLabel?.text = viewModel.textForRowAt(indexPath: indexPath)
        return cell
    }
    
    // MARK: - Table View Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = GoodsViewController()
        if let detailViewModel = viewModel.detailViewModelAt(indexPath: indexPath) {
            viewController.viewModel = detailViewModel
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
