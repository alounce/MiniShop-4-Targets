//
//  ProductsList.swift
//  MiniShop
//
//  Created by Alexander Karpenko on 3/22/18.
//  Copyright © 2018 Alexander Karpenko. All rights reserved.
//

import UIKit

class ProductsList: UITableViewController {

    var viewModel: ProductListViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate,
            let provider = appDelegate.provider else {
                fatalError("Cannot obtain AppDelegate")
        }
        viewModel = ProductListViewModel(provider: provider)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadData()
    }

    func loadData() {
        viewModel.downloadProducts { [weak self] error in
            if let error = error {
                print("Error happened")
                print("\(error.localizedDescription)")
                return
            }
            self?.tableView.reloadData()
        }
    }

    @IBAction func tapRefresh(_ sender: Any) {
        loadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sectionCount()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.itemsCount()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell",
                                                       for: indexPath) as? ProductCell else {
            fatalError("Cannot obtain ProductCell")
        }

        // Configure the cell...
        let product = viewModel.item(byIndex: indexPath.row)
        cell.configure(title: product.model.title, details: product.model.details, price: product.priceString)
        return cell
    }

    override func tableView(_ tableView: UITableView,
                            heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }

}
