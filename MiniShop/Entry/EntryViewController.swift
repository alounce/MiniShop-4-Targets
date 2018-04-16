//
//  EntryViewController.swift
//  MiniShop
//
//  Created by Alexander Karpenko on 4/13/18.
//  Copyright © 2018 Alexander Karpenko. All rights reserved.
//

import UIKit

enum ApplicationType: String {
    case stock = "Stock"
    case shop = "Shop"
}

enum EntryItem: String {
    case catalog = "Product Catalog"
    case incomes = "Income Orders"
    case sales = "Sale Orders"
}

class EntryViewController: UITableViewController {
    
    var provider: DataProvider!
    var catalogVM: ProductListViewModel!
    var incomesVM: OrderListViewModel?
    var salesVM: OrderListViewModel?
    
    var items = [EntryItem]()
    
    var applicationType: ApplicationType {
        guard let targetName = Bundle.main.infoDictionary?["CFBundleName"] as? String,
        let type = ApplicationType(rawValue: targetName) else {
            fatalError("cannot obtain target name")
        }
        return type
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        populateTable()
        configure()
    }
    
    func populateTable() {
        switch applicationType {
        case .shop: items = [.catalog, .sales]
        case .stock: items = [.catalog, .incomes]
        }
    }
    
    func configure() {
        tableView.tableFooterView = UIView()
        title = applicationType.rawValue
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Your items ..."
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "Please select to proceed"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = items[indexPath.row]
        
        switch item {
        case .catalog:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "CatalogCell",
                                                           for: indexPath) as? CatalogCell else {
                fatalError("cannot find CatalogCell")
            }
            return cell
        case .incomes:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "IncomesCell",
                                                           for: indexPath) as? IncomesCell else {
                                                            fatalError("cannot find IncomesCell")
            }
            return cell
        case .sales:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SalesCell",
                                                           for: indexPath) as? SalesCell else {
                                                            fatalError("cannot find SalesCell")
            }
            return cell
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        
        switch item {
        case .catalog:
            let storyboard = UIStoryboard(name: "Catalog", bundle: Bundle.main)
            guard let catalog = storyboard.instantiateViewController(withIdentifier: "ProductsList") as? ProductsList else {
                fatalError("Cannot obtain ProductsList controller")
            }
            self.navigationController!.pushViewController(catalog, animated: true)
        case .incomes:
            let storyboard = UIStoryboard(name: "Stock", bundle: Bundle.main)
            guard let incomes = storyboard.instantiateViewController(withIdentifier: "IncomeOrderList") as? IncomeOrderList else {
                fatalError("Cannot obtain ProductsList controller")
            }
            self.navigationController!.pushViewController(incomes, animated: true)
            
        case .sales:
            let storyboard = UIStoryboard(name: "Shop", bundle: Bundle.main)
            guard let sales = storyboard.instantiateViewController(withIdentifier: "SaleOrderList") as? SaleOrderList else {
                fatalError("Cannot obtain SaleOrderList controller")
            }
            self.navigationController!.pushViewController(sales, animated: true)
        }
    }

}
