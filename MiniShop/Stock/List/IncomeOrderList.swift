//
//  OrdersList.swift
//  MiniShop
//
//  Created by Alexander Karpenko on 3/22/18.
//  Copyright © 2018 Alexander Karpenko. All rights reserved.
//

import UIKit

class IncomeOrderList: UITableViewController {

    var viewModel: OrderListViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate,
            let provider = appDelegate.provider else {
                fatalError("Cannot obtain AppDelegate")
        }
        viewModel = OrderListViewModel(provider: provider)
        self.title = "Store"
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadData()
    }
    
    @IBAction func tapRefresh(_ sender: Any) {
        loadData()
    }
    
    func loadData() {
        viewModel.downloadIncomes { [weak self] error in
            if let error = error {
                print("Error happened")
                print("\(error.localizedDescription)")
                return
            }
            self?.tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.groupsCount
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.itemsCount
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "IncomeOrderCell",
                                                       for: indexPath) as?  IncomeOrderCell else {
            fatalError("Cannot obtain IncomeOrderCell")
        }

        // Configure the cell...
        let orderViewModel = viewModel.getItem(byIndex: indexPath.row)
        cell.configure(details: orderViewModel.summary,
                       date: orderViewModel.date,
                       total: orderViewModel.totalSumString)
        return cell
    }

    override func tableView(_ tableView: UITableView,
                            titleForHeaderInSection section: Int) -> String? {
        return viewModel.summary
    }

    override func tableView(_ tableView: UITableView,
                            heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowOrder" {
            guard let viewer = segue.destination as? IncomeOrderViewer else {
                fatalError("Cannot obtain IncomeOrderViewer controller")
            }
            let idx = self.tableView.indexPathForSelectedRow!.row
            let orderViewModel = viewModel.getItem(byIndex: idx)
            viewer.viewModel = orderViewModel
        }
    }
}
