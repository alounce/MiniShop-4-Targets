//
//  OrderListDataSource.swift
//  MiniShop
//
//  Created by Alexander Karpenko on 3/25/18.
//  Copyright © 2018 Alexander Karpenko. All rights reserved.
//

import Foundation

protocol OrderListDataSource {
    func sectionCount() -> Int
    func itemsCount(forSection section: Int) -> Int
}
