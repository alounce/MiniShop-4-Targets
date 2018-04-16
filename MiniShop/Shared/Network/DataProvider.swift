//
//  DataProvider.swift
//  MiniShop
//
//  Created by Alexander Karpenko on 3/23/18.
//  Copyright © 2018 Alexander Karpenko. All rights reserved.
//

import Foundation
import Alamofire

class DataProvider {

    let baseURLString: String
    
    init(base: String) {
        baseURLString = base
    }

    func downloadProducts(completion: @escaping (Error?, [Product]?) -> Void) {
        let urlString = baseURLString.appending("/products")
        Alamofire.request(urlString).responseData { response in
            if let error = response.error {
                completion(error, nil)
                return
            }

            guard let data = response.data else {
                completion(CustomError.emptyResponse, nil)
                return
            }

            guard  let models = try? JSONDecoder().decode([ProductModel].self, from: data) else {
                completion(CustomError.cannotReadProductsFromJSON, nil)
                return
            }
            let products = models.map { Product(model: $0) }
            Product.cache(products: products)
            completion(nil, products)
        }
    }

    func downloadOrders(ofType type: OrderType?, completion: @escaping (Error?, [Order]?) -> Void) {
        var urlString = baseURLString.appending("/orders")
        if let type = type {
            urlString.append("?type=\(type.rawValue)")
        }

        Alamofire.request(urlString).responseData { response in
            if let error = response.error {
                completion(error, nil)
                return
            }

            guard let data = response.data else {
                completion(CustomError.emptyResponse, nil)
                return
            }
            do {
                let models = try JSONDecoder().decode([OrderModel].self, from: data)
                let orders = models.map { Order(model: $0) }
                completion(nil, orders)
            } catch {
                completion(error, nil)
                return
            }
        }
    }

}
