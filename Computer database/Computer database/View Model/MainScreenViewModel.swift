//
//  MainScreenViewModel.swift
//  Computer database
//
//  Created by Дмитрий Вашлаев on 01.09.18.
//  Copyright © 2018 Дмитрий Вашлаев. All rights reserved.
//

import Foundation

protocol TableViewRefreshing: class {
    func updateScreen()
    func updateToolbarButtons()
}

class MainScreenViewModel {
    // MARK: - Public Properties
    weak var delegate: TableViewRefreshing?
    var currentPage = 0
    lazy var lastPage: Int = {
       return dataModel.lastPage
    }()

    
    // MARK: - Private Properties
    private var goodsList: [Goods]?
    private var dataModel: DataModel
    
    // MARK: - Initializers
    init(_ dataModel: DataModel) {
        self.dataModel = dataModel
    }
    
    // MARK: - Public Methods
    func getList(page: Int) {
        goodsList?.removeAll()
        
        dataModel.getList(page: page) { [weak self] (goods) in
            guard let weakSelf = self else { return }
            weakSelf.goodsList = goods
            weakSelf.delegate?.updateScreen()
            
            if page == (weakSelf.dataModel.lastPage - 1) || page == 0 {
                weakSelf.delegate?.updateToolbarButtons()
            }
        }
    }
    
    func numberOfRows() -> Int {
        return goodsList != nil ? goodsList!.count : 0
    }
    
    func textForRowAt(indexPath: IndexPath) -> String? {
        return goodsList?[indexPath.row].name
    }
    
    func detailTextForRowAt(indexPath: IndexPath) -> String? {
        return goodsList?[indexPath.row].company?.name
    }
}
