//
//  APIManager.swift
//  myApp
//
//  Created by Omar Wasim on 7/18/17.
//  Copyright © 2017 Make School. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import CoreLocation

class APIManager {

    static let apiToken = "11443211f14e75a5"

    
    static func getRestaurants(forCoordinates coordinates: CLLocationCoordinate2D, completionHandler: @escaping ([JSON]) -> Void) {
        
        
        let baseSearchURL = "https://api.eatstreet.com/publicapi/v1/restaurant/search"

        let headers: HTTPHeaders = ["X-Access-Token": APIManager.apiToken]
        
        let parameters: Parameters = ["longitude": coordinates.longitude, "latitude": coordinates.latitude, "method": "both"]
        
        Alamofire.request(baseSearchURL, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseData { (response) in
            let json = JSON(with: response.data!)
            
            if let restaurantsJSON = json["restaurants"].array {
        
                //when done appending, send the array to closure
                completionHandler(restaurantsJSON)
                
            } else {
                completionHandler([])
            }
        }
        
    }
    
    static func getMenuCategories(forRestaurantKey key: String, underBudget budget: Double, foodType: String, completionHandler: @escaping ([MenuCategory]) -> Void) {

        let url = "https://api.eatstreet.com/publicapi/v1/restaurant/\(key)/menu"
        
        let headers: HTTPHeaders = ["X-Access-Token": APIManager.apiToken]
        

        Alamofire.request(url, method: .get, encoding: URLEncoding.default, headers: headers).responseData(completionHandler: { (response) in
            let json = JSON(with: response.data!)
            guard let menuCategoriesJSON = json.array else {
                completionHandler([])
                return
            }
            
            
            var menuCategories = [MenuCategory]()

            for menuCategoryJSON in menuCategoriesJSON {
                //menu category might fail to initialize if json data is nil or if internet is not working.
                if let menuCategory = MenuCategory(usingJSON: menuCategoryJSON, underBudget: budget) {
                    menuCategories.append(menuCategory)
                }
            }
            
            completionHandler(menuCategories)
            
        })

    }

    
}
