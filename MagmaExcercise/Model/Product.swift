//
//  Product.swift
//  MagmaExcercise
//
//  Created by Aldo Bonilla on 19/04/17.
//  Copyright © 2017 Aldo Bonilla. All rights reserved.
//

import Foundation
import RealmSwift

class Product: RealmSubscriber {
    
    var id: Int
    let name: String
    let description: String
    let price: Float
    let showPrice: String
    
    init(dictionary: BasicDictionary) {
        id = dictionary["id"] as? Int ?? -1
        name = dictionary["name"] as? String ?? ""
        description = dictionary["description"] as? String ?? ""
        price = dictionary["price"] as? Float ?? 0.0
        showPrice = dictionary["display_price"] as? String ?? "Price not available"
    }
    
    init(realmObject: ProductRealm) {
        id = realmObject.id
        name = realmObject.name
        description = realmObject.about
        price = realmObject.price
        showPrice = realmObject.showPrice
    }
    
    func createRealmEntity() -> Object {
        return ProductRealm.createProductRealm(self)
    }
}

class ProductRealm: Object {
    
    dynamic var id = 0
    dynamic var name = ""
    dynamic var about = ""
    dynamic var price: Float = 0.0
    dynamic var showPrice = ""
    
    class func createProductRealm(_ product: Product) -> ProductRealm {
        let prodRealm = ProductRealm()
        prodRealm.id = product.id
        prodRealm.name = product.name
        prodRealm.about = product.description
        prodRealm.price = product.price
        prodRealm.showPrice = product.showPrice
        return prodRealm
    }
    
    func createBO() -> Product {
        return Product(realmObject: self)
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
