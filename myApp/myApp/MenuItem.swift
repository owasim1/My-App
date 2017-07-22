//
//  MenuItem.swift
//  myApp
//
//  Created by Omar Wasim on 7/18/17.
//  Copyright © 2017 Make School. All rights reserved.
//

import Foundation
import SwiftyJSON


class MenuItem {
    
    var key: String = ""
    var name: String = ""

    var price: Double = 0
    
    var description: String?
    
    
    init?(json: JSON) {
        guard let key = json["apiKey"].string,
        let name = json["name"].string,
        let price = json["basePrice"].double else{
            return
        }
        
        self.key = key
        self.name = name
        self.price = price
        
        if let description = json["description"].string {
            self.description = description
        }
        
        
    }
    
}
