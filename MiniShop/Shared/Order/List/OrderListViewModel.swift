//
//  OrderListViewModel.swift
//  MiniShop
//
//  Created by Alexander Karpenko on 3/23/18.
//  Copyright © 2018 Alexander Karpenko. All rights reserved.
//

import Foundation

class OrderListViewModel {
    // working with the data
    var orders = [Order]()
    var provider: DataProvider

    init(provider: DataProvider) {
        self.provider = provider
    }

    func downloadIncomes(completion: @escaping (Error?) -> Void) {
        provider.downloadOrders(ofType: .income) { [weak self] err, orders in
            if let orders = orders {
                self?.orders = orders
            }
            completion(err)
        }
    }

    func downloadSales(completion: @escaping (Error?) -> Void) {
        provider.downloadOrders(ofType: .sale) { [weak self] err, orders in
            if let orders = orders {
                self?.orders = orders
            }
            completion(err)
        }
    }

    // custom properties
    var totalSum: Int {
        return orders
            .map { $0.totalSum }
            .reduce(0, +)
    }

    var totalSumString: String {
        return Formatter.stringFromMoney(totalSum)
    }

    var summary: String {
        return "\(itemsCount) orders for \(totalSumString) in total"
    }

    // datasource
    let groupsCount: Int = 1
    var itemsCount: Int { return orders.count }
    
    func getItem(byIndex index: Int) -> OrderViewModel {
        let order = orders[index]
        switch order.type {
        case OrderType.income.rawValue: return IncomeOrderViewModel(order: order)
        case OrderType.sale.rawValue: return SaleOrderViewModel(order: order)
        default: fatalError("Unknown order type: \(order.type)")
        }
    }
}
