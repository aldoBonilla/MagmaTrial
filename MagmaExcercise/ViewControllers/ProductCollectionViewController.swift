//
//  ProductCollectionViewController.swift
//  MagmaExcercise
//
//  Created by Aldo Bonilla on 19/04/17.
//  Copyright © 2017 Aldo Bonilla. All rights reserved.
//

import UIKit

private let reuseIdentifier = "ProductCell"

class ProductCollectionViewController: UICollectionViewController {
    
    var dataProvider: ProductDataProviderProtocol?
    var productSelected: Product?
    var showDetailForProduct: ((Product) -> ())?

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.dataSource = dataProvider
        dataProvider?.collectionView = collectionView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        dataProvider?.collectionView?.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showDetailForProduct?(dataProvider!.productList[indexPath.row])
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
