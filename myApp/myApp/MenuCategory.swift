//
//  MenuCategory.swift
//  myApp
//
//  Created by Omar Wasim on 7/18/17.
//  Copyright © 2017 Make School. All rights reserved.
//

import Foundation
import SwiftyJSON

class MenuCategory {
    
    var key: String = ""
    var name: String = ""

    var items: [MenuItem]?
    
    init?(json: JSON) {
        
        
        guard let key = json["apiKey"].string,
            let name = json["name"].string else {
                return
        }
        
        var menuItems = [MenuItem]()

        if let itemsJSON = json["items"].array {
            for itemJSON in itemsJSON {
                let menuItem = MenuItem(json: itemJSON)
                menuItems.append(menuItem!)
            }
        }
        
        self.key = key
        self.name = name
        self.items = menuItems
      
    }
    
    
}
