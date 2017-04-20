//
//  ProductsTableViewController.swift
//  MagmaExcercise
//
//  Created by Aldo Bonilla on 19/04/17.
//  Copyright © 2017 Aldo Bonilla. All rights reserved.
//

import UIKit

class ProductsTableViewController: UITableViewController {
    
    var products: [Product] = []
    var dataProvider: ProductDataProviderProtocol?
    var productSelected: Product?
    var showDetailForProduct: ((Product) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = dataProvider
        dataProvider?.tableView = tableView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dataProvider?.tableView?.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let addFavorite = UITableViewRowAction(style: .normal, title: "FAV", handler: {action, index in
            let favProduct = self.dataProvider!.productList[indexPath.row]
            RealmApi.sharedInstance.writeEntity(favProduct.createRealmEntity())
            DispatchQueue.main.async(execute: {
                showSimpleAlertWithTitle(title: "Product added to your favorites", message: "", viewController: self)
            })
        })
        addFavorite.backgroundColor = UIColor.blue
        return [addFavorite]
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showDetailForProduct?(dataProvider!.productList[indexPath.row])
    }
}
