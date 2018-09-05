//
//  DetailViewModel.swift
//  Computer database
//
//  Created by Дмитрий Вашлаев on 02.09.18.
//  Copyright © 2018 Дмитрий Вашлаев. All rights reserved.
//

import UIKit

protocol DetailViewRefreshing: class {
    func updateView()
    func updateImage()
    func updateTableView()
}

class DetailViewModel {
    // MARK: - Public Properties
    var name: String? { get { return item.name } }
    var companyName: String? { get { return item.company?.name } }
    var introduced: String? {
        get {
            guard let _ = item.introduced else { return nil }
            
            let isoDateFormatter = ISO8601DateFormatter()
            let formatter = DateFormatter()
            formatter.dateFormat = "dd MMM yyyy"
            
            guard let newDate = isoDateFormatter.date(from:item.introduced!) else { return nil }
            return formatter.string(from: newDate)
        }
    }
    var discounted: String? {
        get {
            guard let _ = item.discounted else { return nil }
            
            let isoDateFormatter = ISO8601DateFormatter()
            let formatter = DateFormatter()
            formatter.dateFormat = "dd MMM yyyy"
            
            guard let newDate = isoDateFormatter.date(from:item.discounted!) else { return nil }
            return formatter.string(from: newDate)
        }
    }
    var goodsDescription: String? { get { return item.description } }
    var image: UIImage?
    weak var delegate: DetailViewRefreshing?
    
    
    // MARK: - Pirvate Properties
    private var item: Goods
    private var dataModel: DataModel
    
    // MARK: - Initializers
    init(item: Goods, dataModel: DataModel) {
        self.item = item
        self.dataModel = dataModel
    }
    
    // MARK: - Public Methods
    func getInfo() {
        guard let goodsID = item.id else { return }
        
        dataModel.getGoodsWith(id: goodsID, completionHandler: { [weak self] (goods) in
            if let weakSelf = self, let newGoods = goods {
                weakSelf.item.company = newGoods.company // !!!
                weakSelf.item.description = newGoods.description
                weakSelf.item.introduced = newGoods.introduced
                weakSelf.item.discounted = newGoods.discounted
                weakSelf.item.imageUrl = newGoods.imageUrl
                
                weakSelf.delegate?.updateView()
                
                if let urlString = newGoods.imageUrl {
                    weakSelf.downloadImage(urlString: urlString, completionHandler: { [weak self] (image) in
                        guard let weakSelf = self else { return }
                        weakSelf.image = image
                        weakSelf.delegate?.updateImage()
                    })
                }
            }
        })
        
        dataModel.getRelatedGoodsWith(id: goodsID, completionHandler: { [weak self] (relatedGoodsList) in
            guard let weakSelf = self else { return }
            weakSelf.item.relatedGoods = relatedGoodsList
            weakSelf.delegate?.updateTableView()
        })
    }
    
    func detailViewModelAt(indexPath: IndexPath) -> DetailViewModel? {
        guard let relatedItem = item.relatedGoods?[indexPath.row] else { return nil }
        var  goods = Goods()
        goods.id = relatedItem.id
        goods.name = relatedItem.name
        return DetailViewModel(item: goods, dataModel: dataModel)
    }
    
    
    // MARK: - Table View Data Source
    func numberOfRows() -> Int {
        return item.relatedGoods != nil ? item.relatedGoods!.count : 0
    }
    
    func textForRowAt(indexPath: IndexPath) -> String? {
        return item.relatedGoods?[indexPath.row].name
    }
    
    
    // MARK: - Private Methods
    private func downloadImage(urlString: String, completionHandler: @escaping (UIImage?) -> Void) {
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { (data, urlRsponse, err) in
                if err == nil, let receivedData = data {
                    let newImage = UIImage(data: receivedData)
                    completionHandler(newImage)
                }
                }.resume()
        }
    }
}
