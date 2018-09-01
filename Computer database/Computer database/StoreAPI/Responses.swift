//
//  ListResponse.swift
//  Computer database
//
//  Created by Дмитрий Вашлаев on 01.09.18.
//  Copyright © 2018 Дмитрий Вашлаев. All rights reserved.
//

import Foundation

struct GoodsListResponse: Decodable {
    var items: [Goods]?
    var page: Int?
    var offset: Int?
    var total: Int?
}

struct RelatedGoodsResponse: Decodable {
    var relatedGoods: [RelatedGoods]?
}
