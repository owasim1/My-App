
//
//  Restaurant.swift
//  myApp
//
//  Created by Omar Wasim on 7/18/17.
//  Copyright © 2017 Make School. All rights reserved.
//

import Foundation
import SwiftyJSON

class Restaurant: Result {
    
    var key: String = ""
    var name: String = ""
    var longitude = 0.0
    var latitude = 0.0
    var menuCategories = [MenuCategory]()
    
    init(key: String, name: String, longitude: Double, latitude: Double) {
        super.init()
        
        self.name = name
        self.key = key
        self.longitude = longitude
        self.latitude = latitude
    }
    
    init?(json: JSON) {
        super.init()
        
        guard let keyFromJSON = json["apiKey"].string,
            let nameFromJSON = json["name"].string, let longitudeFromJSON = json["longitude"].double, let latitudeFromJSON = json["latitude"].double else {
            return
        }
        
        self.key = keyFromJSON
        self.name = nameFromJSON
        self.longitude = longitudeFromJSON
        self.latitude = latitudeFromJSON
        
        super.nameOfRestaurant = self.name

    }
    
}
