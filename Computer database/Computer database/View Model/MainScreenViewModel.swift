//
//  MainScreenViewModel.swift
//  Computer database
//
//  Created by Дмитрий Вашлаев on 01.09.18.
//  Copyright © 2018 Дмитрий Вашлаев. All rights reserved.
//

import Foundation

class MainScreenViewModel {
    // MARK: - Private Properties
    private var dataModel: DataModel
    
    // MARK: - Initializers
    init(_ dataModel: DataModel) {
        self.dataModel = dataModel
    }
    
    func getList(page: Int) {
        dataModel.getList(page: page)
    }
    
    // TODO: - Delete this method
    func getRelatedWith(_ id: Int) {
        dataModel.getRelatedGoodsWith(id: id)
    }
}
