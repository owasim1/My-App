//
//  ResultsTableViewCell.swift
//  myApp
//
//  Created by Omar Wasim on 7/11/17.
//  Copyright © 2017 Make School. All rights reserved.
//

import UIKit

class ResultsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameOfRestaurantLabel: UILabel!

    @IBOutlet weak var distanceLabel: UILabel?
    
    @IBOutlet weak var restaurantAddress: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
