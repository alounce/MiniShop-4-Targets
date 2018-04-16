//
//  SaleOrderViewModel.swift
//  MiniShop
//
//  Created by Alexander Karpenko on 3/23/18.
//  Copyright © 2018 Alexander Karpenko. All rights reserved.
//

import Foundation

class SaleOrderViewModel {

    // MARK: - data
    var order: Order
    
    init(order: Order) {
        self.order = order
    }
}

extension SaleOrderViewModel: OrderViewModel {

    // MARK: - properties
    var type: OrderType { return .sale }
    // MARK: summary
    var number: String {
        return "# \(order.id)"
    }
    
    var summary: String {
        return String(format: "\(order.details.count) positions with \(order.totalQty)pcs in total")
    }

    var totalQty: String {
        return Formatter.stringFromQty(order.totalQty) + " in total"
    }

    var date: String {
        return Formatter.stringFromDateString(order.date)
    }

    var totalSumString: String {
        return Formatter.stringFromMoney(order.totalSum)
    }

    // MARK: details
    func detailName(forIndex index: Int) -> String {
        return order.details[index].productName
    }

    func detailInfo(forIndex index: Int) -> String {
        return order.details[index].productInfo
    }

    func detailValue(forIndex index: Int) -> String {
        let qty = detailQtyString(forIndex: index)
        let price = detailPriceString(forIndex: index)
        return "\(qty) * \(price)"
    }

    func detailPriceString(forIndex index: Int) -> String {
        let money = order.details[index].price
        return Formatter.stringFromMoney(money)
    }

    func detailSumString(forIndex index: Int) -> String {
        let money = order.details[index].sum
        return Formatter.stringFromMoney(money)
    }

    func detailQtyString(forIndex index: Int) -> String {
        let qty = order.details[index].qty
        return Formatter.stringFromQty(qty)
    }
}

extension SaleOrderViewModel: OrderListDataSource {
    
    func sectionCount() -> Int {
        return 2
    }
    
    func itemsCount(forSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return order.details.count
        default: return 0
        }
    }
}
