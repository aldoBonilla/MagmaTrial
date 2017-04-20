//
//  DetailViewController.swift
//  MagmaExcercise
//
//  Created by Aldo Bonilla on 19/04/17.
//  Copyright © 2017 Aldo Bonilla. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var txtDescription: UITextView!
    @IBOutlet weak var imgProduct: UIImageView!
    var product: Product?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lblName.styleWithText(product?.name, labelStyle: .Title, aligment: .left)
        lblPrice.styleWithText(product?.showPrice, labelStyle: .Detail, aligment: .left)
        txtDescription.text = product?.description
        txtDescription.font = FontMedium12
        txtDescription.textColor = UIColor.lightGray
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
