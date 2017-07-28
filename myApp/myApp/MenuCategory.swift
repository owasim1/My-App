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
    
    var key = String()
    var name = String()

    var items: [MenuItem]?
    
    init(key: String, name: String) {
        self.key = key
        self.name = name
    }
    
    init?(usingJSON json: JSON, underBudget budget: Double) {
        
        guard let key = json["apiKey"].string,
            let name = json["name"].string else {
                //if fails to create a new object, returns nil.
                return
        }
        
        
        var menuItems = [MenuItem]()

        if let itemsJSON = json["items"].array {
            for itemJSON in itemsJSON {
                if budget >= itemJSON["basePrice"].doubleValue {
                    let menuItem = MenuItem(json: itemJSON)
                    menuItems.append(menuItem!)
                }
            }
        }
        self.items = menuItems
        if (self.items?.count)! > 0{
            self.key = key
            self.name = name
        } else {
           return
      
    }
  }
}
