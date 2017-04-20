//
//  RootViewController.swift
//  MagmaExcercise
//
//  Created by Aldo Bonilla on 19/04/17.
//  Copyright © 2017 Aldo Bonilla. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var containerProductTVC: UIView!
    @IBOutlet weak var containerProductCVC: UIView!
    
    var dataProvider: ProductDataProviderProtocol?
    var productTVC: ProductsTableViewController?
    var productCVC: ProductCollectionViewController?
    var productForDetail: Product?
    var showingList = false
    var firstAppear = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Products"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(changeViewMode))
        initDataProvider()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if firstAppear == true {
            dataProvider!.fetchProducts()
            firstAppear = false
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initDataProvider() {
        if dataProvider == nil {
            dataProvider = ProductDataProvider()
        }
    }

    func changeViewMode() {
        if showingList == true {
            UIView.transition(with: viewContainer, duration: 0.5, options: .transitionFlipFromRight, animations: {
                self.containerProductTVC.isHidden = true
            }, completion: { complete in
                self.containerProductCVC.isHidden = false
                self.showingList = false
            })
        } else {
            UIView.transition(with: viewContainer, duration: 0.5, options: .transitionFlipFromLeft, animations: {
                self.containerProductCVC.isHidden = true
            }, completion: { complete in
                self.containerProductTVC.isHidden = false
                self.showingList = true
            })
        }
    }
    
    ///Saves the product to show the detail
    private func showProductDetail(product: Product) {
        productForDetail = product
        DispatchQueue.main.async(execute: {
            self.performSegue(withIdentifier: "showProductDetail", sender: self)
        })
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        initDataProvider()
        if segue.identifier == "embebedProductTVC" {
            guard let destinationVC = segue.destination as? ProductsTableViewController else {
                return
            }
            productTVC = destinationVC
            productTVC?.dataProvider = dataProvider
            productTVC?.showDetailForProduct = showProductDetail
        } else if segue.identifier == "embebedProductCVC" {
            guard let destinationVC = segue.destination as? ProductCollectionViewController else {
                return
            }
            productCVC = destinationVC
            productCVC?.dataProvider = dataProvider
            productCVC?.showDetailForProduct = showProductDetail
        } else if segue.identifier == "showProductDetail" {
            guard let detailVC = segue.destination as? DetailViewController else { return }
            detailVC.product = productForDetail
        }
    }
    
}
