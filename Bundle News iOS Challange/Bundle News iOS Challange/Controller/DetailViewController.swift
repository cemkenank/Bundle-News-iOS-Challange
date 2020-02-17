//
//  DetailViewController.swift
//  Bundle News iOS Challange
//
//  Created by MrDark on 16.02.2020.
//  Copyright © 2020 MrDark. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var productImageView: UIImageView!
    @IBOutlet var categoryNameLabel: UILabel!
    @IBOutlet var productNameLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!


    var detailCategoryNameString = ""
    var detailProductNameString = ""
    var detailPriceString = ""
    var detailImageUrlString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        productNameLabel.text = detailProductNameString
        categoryNameLabel.text = detailCategoryNameString
        priceLabel.text = detailPriceString
        productImageView.loadImage(url: URL(string: detailImageUrlString)!)

    }

    @IBAction func backToProductsPage(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

}
