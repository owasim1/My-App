//
//  DisplayRestaurantMenuController.swift
//  myApp
//
//  Created by Omar Wasim on 7/21/17.
//  Copyright © 2017 Make School. All rights reserved.
//

import UIKit
import Foundation

class DisplayRestaurantMenuController: UIViewController {
    
    var restuarantTitle: String?
    var menuCategorySection = [String]()
    var menuCategoryItemsRow = [[String]]()
    
    
    @IBOutlet weak var restaurantTitleLabel: UILabel!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        if let title = restuarantTitle
        {
            restaurantTitleLabel.text = title
        }
    }
}
