//
//  Order.swift
//  MiniShop
//
//  Created by Alexander Karpenko on 3/22/18.
//  Copyright © 2018 Alexander Karpenko. All rights reserved.
//

import Foundation

class Detail {
    var model: DetailModel
    
    init(model: DetailModel) {
        self.model = model
    }

    var product: Product {
        return Product.productById[model.productId]!
    }
    var productName: String { return product.title }
    var productInfo: String { return product.details }
    var qty: Int { return model.qty }
    var price: Int { return product.price }
    var sum: Int { return qty * price }
}

class Order {
    private static var counter: Int = 0
    
    private static func getId() -> Int {
        counter -= 1
        return counter
    }
    
    var model: OrderModel
    
    init(model: OrderModel) {
        self.model = model
        self.details = model.details.map { Detail(model: $0) }
    }

    var id: Int { return model.id }
    var type: Int { return model.type }
    var date: String { return model.date }
    var details: [Detail]

    var totalQty: Int {
        return details
            .map { $0.qty }
            .reduce(0, +)
    }

    var totalSum: Int {
        return details.map { $0.sum }.reduce(0, +)
    }
}

extension Order {
    convenience init(type: Int) {
        let newId = Order.getId()
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        let dateString = formatter.string(from: Date())
        let details = [DetailModel]()
        let model = OrderModel(id: newId, type: type, date: dateString, details: details)
        self.init(model: model)
    }
}
