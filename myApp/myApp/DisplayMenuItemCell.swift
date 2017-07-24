//
//  DisplayMenuItemCell.swift
//  myApp
//
//  Created by Omar Wasim on 7/24/17.
//  Copyright © 2017 Make School. All rights reserved.
//

import UIKit

class DisplayMenuItemCell: UITableViewCell {

    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemPriceLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
