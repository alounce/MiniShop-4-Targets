//
//  File.swift
//  MiniShop
//
//  Created by Alexander Karpenko on 3/25/18.
//  Copyright © 2018 Alexander Karpenko. All rights reserved.
//

import Foundation

struct ProductViewModel {
    var model: Product
    
    var priceString: String {
        return Formatter.stringFromMoney(model.price)
    }
}
