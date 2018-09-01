//
//  Goods.swift
//  Computer database
//
//  Created by Дмитрий Вашлаев on 01.09.18.
//  Copyright © 2018 Дмитрий Вашлаев. All rights reserved.
//

import Foundation

struct Company: Decodable {
    var id: Int?
    var name: String?
}

struct RelatedGoods:Decodable {
    var id: Int?
    var name: String?
}

struct Goods: Decodable {
    var id: Int?
    var name: String?
    var company: Company?
    var introduced: String?
    var discounted: String?
    var imageUrl: String?
    var description: String?
    var relatedGoods: [RelatedGoods]?
}
