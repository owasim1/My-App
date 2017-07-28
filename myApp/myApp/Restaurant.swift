
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
    var foodType: [String]?
    
    init(key: String, name: String, longitude: Double, latitude: Double, foodType: [String]?) {
        super.init()
        
        self.name = name
        self.key = key
        self.longitude = longitude
        self.latitude = latitude
        self.foodType = foodType
    }
    
    init?(json: JSON) {
        super.init()
        
        guard let keyFromJSON = json["apiKey"].string,
            let nameFromJSON = json["name"].string, let longitudeFromJSON = json["longitude"].double, let latitudeFromJSON = json["latitude"].double, let foodTypeFromJSON = json["foodTypes"].array else {
            return
        }
        
        self.key = keyFromJSON
        self.name = nameFromJSON
        self.longitude = longitudeFromJSON
        self.latitude = latitudeFromJSON
        self.foodType = foodTypeFromJSON.map {$0.stringValue}.filter({$0 != ""})
        
        for individualString in self.foodType!
        {
            self.foodType![self.foodType!.index(of: individualString)!] = individualString.lowercased()
        }
        
        super.nameOfRestaurant = self.name

    }
    
}
