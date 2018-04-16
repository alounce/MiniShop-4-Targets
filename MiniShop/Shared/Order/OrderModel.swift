//
//  OrderModel.swift
//  MiniShop
//
//  Created by Alexander Karpenko on 3/22/18.
//  Copyright © 2018 Alexander Karpenko. All rights reserved.
//

import Foundation

struct DetailModel: Codable {
    var productId: Int
    var qty: Int

    enum CodingKeys: String, CodingKey {
        case productId = "product"
        case qty = "qty"
    }
}

struct OrderModel: Codable {
    var id: Int
    var type: Int
    var date: String
    var details = [DetailModel]()

    mutating func addDetail(productId: Int, qty: Int) {
        let detail = DetailModel(productId: productId, qty: qty)
        details.append(detail)
    }

    mutating func removeDetail(productId: Int) {
        if let index = details.index(where: { $0.productId == productId }) {
            details.remove(at: index)
        }
    }
}
