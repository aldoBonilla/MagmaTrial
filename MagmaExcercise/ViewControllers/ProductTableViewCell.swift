//
//  ProductTableViewCell.swift
//  MagmaExcercise
//
//  Created by Aldo Bonilla on 19/04/17.
//  Copyright © 2017 Aldo Bonilla. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var imgProduct: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setupWithProduct(_ product: Product) {
        lblName.styleWithText(product.name, labelStyle: .CellTitle, aligment: .left)
        lblPrice.styleWithText(product.showPrice, labelStyle: .CellDetail, aligment: .right)
        lblDescription.styleWithText(product.description, labelStyle: .SmallText, aligment: .left)
    }
}
