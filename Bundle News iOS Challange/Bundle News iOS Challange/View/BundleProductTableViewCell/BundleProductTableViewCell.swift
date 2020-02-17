//
//  BundleProductTableViewCell.swift
//  Bundle News iOS Challange
//
//  Created by MrDark on 15.02.2020.
//  Copyright © 2020 MrDark. All rights reserved.
//

import UIKit

class BundleProductTableViewCell: UITableViewCell {
    
    @IBOutlet var categoryTextLabel: UILabel!
    @IBOutlet var productNameTextLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var productImageView: UIImageView!
    @IBOutlet var productDetailButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
