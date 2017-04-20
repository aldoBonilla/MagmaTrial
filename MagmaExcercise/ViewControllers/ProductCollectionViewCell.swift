//
//  ProductCollectionViewCell.swift
//  KokonutTemplate
//
//  Created by Aldo Bonilla on 27/08/16.
//  Copyright © 2016 Aldo Bonilla. All rights reserved.
//  CollectionViewCell para usar en la pantalla principal

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
 
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var imgProduct: UIImageView!

    func setupWithProduct(_ product: Product) {
        lblName.styleWithText(product.name, labelStyle: .CellTitle, aligment: .center)
        lblPrice.styleWithText(product.showPrice, labelStyle: .CellDetail, aligment: .center)
        lblDescription.styleWithText(product.description, labelStyle: .SmallText, aligment: .left)
    }
}
