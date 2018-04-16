//
//  ProductModel.swift
//  MiniShop
//
//  Created by Alexander Karpenko on 3/22/18.
//  Copyright © 2018 Alexander Karpenko. All rights reserved.
//

import Foundation

struct ProductModel: Codable {
    let id: Int
    let title: String
    let details: String
    let price: Int
}
