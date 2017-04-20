//
//  ProductDataProvider.swift
//  MagmaExcercise
//
//  Created by Aldo Bonilla on 19/04/17.
//  Copyright © 2017 Aldo Bonilla. All rights reserved.
//

import UIKit

class ProductDataProvider: NSObject, ProductDataProviderProtocol {
    
    weak var tableView: UITableView?
    weak var collectionView: UICollectionView?
    var productList: [Product] = []
    
    func fetchProducts() {
        HUD.showWithStatus("Getting Products")
        LibraryApi.sharedInstance.getProducts({ products, error in
            if error == nil {
                self.productList = products!
                DispatchQueue.main.async(execute: {
                    HUD.dismiss()
                    self.tableView?.reloadData()
                    self.collectionView?.reloadData()
                })
            } else {
                DispatchQueue.main.async(execute: {
                    HUD.dismiss()
                    showSimpleAlertWithTitle(title: "Couldnt get the products List, please try later", message: "", viewController: nil)
                })
            }
        })
    }
    
    func productAtIndexPath(indexPath: NSIndexPath) -> Product {
        return productList[indexPath.row]
    }
}

extension ProductDataProvider: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath) as! ProductTableViewCell
        let thisProduct = productList[indexPath.row]
        cell.setupWithProduct(thisProduct)
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
    }
}

extension ProductDataProvider: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! ProductCollectionViewCell
        let thisProduct = productList[indexPath.row]
        cell.setupWithProduct(thisProduct)
        return cell
    }
}
