//
//  DataModel.swift
//  Computer database
//
//  Created by Дмитрий Вашлаев on 01.09.18.
//  Copyright © 2018 Дмитрий Вашлаев. All rights reserved.
//

import Foundation

class DataModel {
    // MARK: - Public Methods
    var lastPage = 0
    var offset = 1 // items perPage
    
    // MARK: - Private properties
    private let storeAPI = StoreAPI()
    
    // MARK: - Public Methods
    func getList(page: Int, completionHandler: @escaping ([Goods]?) -> Void) {
        storeAPI.downloadGoodsList(page: page) { [weak self] (receivedData) in
            do {
                guard let weakSelf = self else { return }
                guard let data = receivedData else { return }
                // Parsing JSON
                let result = try JSONDecoder().decode(GoodsListResponse.self, from: data)
                
                if let goods = result.items, let total = result.total, let page = result.page {
                    completionHandler(goods)
                    
                    if page == 0 {
                        weakSelf.offset = goods.count
                        if goods.count > 0 {
                            weakSelf.lastPage = total / weakSelf.offset + 1
                        }
                    }
                }
                
            } catch let jsonErr {
                print("JSON serialization error:", jsonErr)
            }
        }
    }
    
    func getRelatedGoodsWith(id: Int) {
        storeAPI.downloadRelatedGoodsWith(id) { [weak self] (receivedData) in
            do {
                guard let weakSelf = self else { return }
                guard let data = receivedData else { return }
                // Parsing JSON
                let relatedGoodsList = try JSONDecoder().decode([RelatedGoods].self, from: data)
                
                for goods in relatedGoodsList {
                    
                }
                
            } catch let jsonErr {
                print("JSON serialization error:", jsonErr)
            }
        }
    }
}
