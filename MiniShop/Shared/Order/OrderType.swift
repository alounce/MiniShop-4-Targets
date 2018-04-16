//
//  OrderType.swift
//  MiniShop
//
//  Created by Alexander Karpenko on 3/23/18.
//  Copyright © 2018 Alexander Karpenko. All rights reserved.
//

import Foundation

enum OrderType: Int {
    case income = 1
    case sale = 2

    var icon: String {
        switch self {
        case .income: return "🚚"
        case .sale: return "🛒"
        }
    }

    var text: String {
        switch self {
        case .income: return "Income"
        case .sale: return "Sale"
        }
    }
}
