//
//  ProductDataProviderProtocol.swift
//  MagmaExcercise
//
//  Created by Aldo Bonilla on 19/04/17.
//  Copyright © 2017 Aldo Bonilla. All rights reserved.
//  Protocolo para alimentar a las vistas, metodos comunes de las 2 para no tener codigo repetido


import UIKit

protocol ProductDataProviderProtocol: UITableViewDataSource, UICollectionViewDataSource {
    weak var tableView: UITableView? { get set }
    weak var collectionView: UICollectionView? { get set }
    var productList: [Product] { get set }
    func fetchProducts()
}
