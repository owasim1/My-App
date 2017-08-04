
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
    var streetAddress = ""
    var city = ""
    var state = ""
    var menuCategories = [MenuCategory]()
    var foodType: [String]?
    
    init(key: String, name: String, longitude: Double, latitude: Double, foodType: [String]?, streetAddress: String) {
        super.init()
        
        self.name = name
        self.key = key
        self.longitude = longitude
        self.latitude = latitude
        self.foodType = foodType
        self.streetAddress = streetAddress
    }
    
    init?(json: JSON) {
        super.init()
        
        guard let keyFromJSON = json["apiKey"].string,
            let nameFromJSON = json["name"].string, let longitudeFromJSON = json["longitude"].double, let latitudeFromJSON = json["latitude"].double, let foodTypeFromJSON = json["foodTypes"].array, let streetAddressFromJSON = json["streetAddress"].string, let cityFromJSON = json["city"].string, let stateFromJSON = json["state"].string else {
            return
        }
        
        self.key = keyFromJSON
        self.name = nameFromJSON
        self.longitude = longitudeFromJSON
        self.latitude = latitudeFromJSON
        self.foodType = foodTypeFromJSON.map{$0.stringValue}.filter({$0 != ""})
        self.streetAddress = streetAddressFromJSON
        self.city = cityFromJSON
        self.state = stateFromJSON
        
        for individualString in self.foodType!
        {
            self.foodType![self.foodType!.index(of: individualString)!] = individualString.lowercased()
        }
        
        super.nameOfRestaurant = self.name

    }
    
}
