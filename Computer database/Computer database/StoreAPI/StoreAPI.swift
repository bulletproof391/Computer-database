//
//  StoreAPI.swift
//  Computer database
//
//  Created by Дмитрий Вашлаев on 01.09.18.
//  Copyright © 2018 Дмитрий Вашлаев. All rights reserved.
//

import Foundation

fileprivate let storeURLString = "http://testwork.nsd.naumen.ru/"

enum API: String {
    case host = "testwork.nsd.naumen.ru"
    case scheme = "http"
    case computers = "/rest/computers"
    case page = "p"
    case related = "similar"
}

class StoreAPI {
    
    // MARK: - Public Methods
    func downloadGoodsList(page: Int, completionHandler: @escaping (Data?) -> Void) {
//        http://testwork.nsd.naumen.ru/rest/computers?p=2
        
        var components = URLComponents()
        components.scheme = API.scheme.rawValue
        components.host = API.host.rawValue
        components.path = API.computers.rawValue
        let queryPage = URLQueryItem(name: API.page.rawValue, value: String(page))
        
        components.queryItems = [queryPage]
        
        if let url = components.url {
            URLSession.shared.dataTask(with: url) { (data, urlRsponse, err) in
                if err == nil {
                    completionHandler(data)
                }
                }.resume()
        }
    }
    
    func downloadGoodsWith(id: Int, completionHandler: @escaping (Data?) -> Void) {
//        http://testwork.nsd.naumen.ru/rest/computers/14
    }
    
    func downloadRelatedGoodsWith(_ id: Int, completionHandler: @escaping (Data?) -> Void) {
//        http://testwork.nsd.naumen.ru/rest/computers/14/similar
        
        var components = URLComponents()
        components.scheme = API.scheme.rawValue
        components.host = API.host.rawValue
        components.path = "\(API.computers.rawValue)/\(id)/\(API.related.rawValue)"
        
        if let url = components.url {
            URLSession.shared.dataTask(with: url) { (data, urlRsponse, err) in
                if err == nil {
                    completionHandler(data)
                }
                }.resume()
        }
    }
}
