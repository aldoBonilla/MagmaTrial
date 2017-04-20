//
//  ProductRootViewControllerTests.swift
//  MagmaExcercise
//
//  Created by Aldo Bonilla on 19/04/17.
//  Copyright © 2017 Aldo Bonilla. All rights reserved.
//

import XCTest
import UIKit

@testable import MagmaExcercise

class ProductRootViewControllerTests: XCTestCase {
    
    var viewController: RootViewController!
    
    override func setUp() {
        super.setUp()
        
        viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RootViewController") as! RootViewController
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDataProviderHasTableViewPropertySetAfterLoading() {
        
        let mockDataProvider = MockDataProvider()
        viewController.dataProvider = mockDataProvider
        
        XCTAssertNil(mockDataProvider.tableView, "Antes de ser creada el TableView debe de ser nil")
        let _ = viewController.view
        
        XCTAssertTrue(mockDataProvider.tableView != nil, "La tabla ya deberia ser setteada ")
        XCTAssert(mockDataProvider.tableView === viewController.productTVC?.tableView, "The table view should be set to the table view of the data source")
    }
}

//  Clase creada para emular el data provider
class MockDataProvider: NSObject, ProductDataProviderProtocol {
    weak var tableView: UITableView?
    weak var collectionView: UICollectionView?
    var productList = [Product]()
    func fetchProducts() { }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return 1 }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool { return true }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) { }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { return 1 }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}
