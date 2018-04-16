//
//  Product.swift
//  MiniShop
//
//  Created by Alexander Karpenko on 3/22/18.
//  Copyright © 2018 Alexander Karpenko. All rights reserved.
//

import Foundation

class Product {

    // MARK: - Cache implementation
    static var productById = [Int: Product]()
    
    static func cache(products: [Product]) {
        productById = products
            .reduce([Int: Product]()) { lookup, product -> [Int: Product] in
                var lookup = lookup
                lookup[product.id] = product
                return lookup
        }
    }

    // MARK: - Properties
    let model: ProductModel
    var id: Int { return model.id }
    var title: String { return model.title }
    var details: String { return model.details }
    var price: Int { return model.price }

    // MARK: - Initializer
    init(model: ProductModel) {
        self.model = model
    }

}
