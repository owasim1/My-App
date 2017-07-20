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

    
    static func getRestaurants(forCoordinates coordinates: CLLocationCoordinate2D, completionHandler: @escaping ([Restaurant]) -> Void) {
        
        
        let baseSearchURL = "https://api.eatstreet.com/publicapi/v1/restaurant/search"
        

        let headers: HTTPHeaders = ["X-Access-Token": APIManager.apiToken]

        let params: Parameters = ["street-address" : "Make School, San Fransisco", "method": "both"]
        
        let parameters: Parameters = ["longitude": coordinates.longitude, "latitute": coordinates.latitude, "method": "both"]
        
        Alamofire.request(baseSearchURL, method: .get, parameters: params, encoding: URLEncoding.default, headers: headers).responseData { (response) in
            let json = JSON(with: response.data!)
            
            if let restaurantsJSON = json["restaurants"].array {
                
                
                //create array for keys
//                var restaurantKeysArray = [String]()
                var restaurants = [Restaurant]()
                
                //iterate through every restaurant to get a key
                for restaurantJSON in restaurantsJSON {
                    
                    
                    guard let restaurant = Restaurant(json: restaurantJSON) else {
                       return
                    }
                    
                    
                    //append each key to keys array
                    restaurants.append(restaurant)

                }
                
                //when done appending, send the array to closure
                completionHandler(restaurants)
                
            } else {
                completionHandler([])
            }
        }
        
    }
    
    static func getMenuCategories(forRestaurantKey key: String, underBudget budget: Double, completionHandler: @escaping ([MenuCategory]) -> Void) {

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
                if let menuCategory = MenuCategory(usingJSON: menuCategoryJSON, underBudget: budget) {
                    menuCategories.append(menuCategory)
                }
            }
            
            completionHandler(menuCategories)
            
        })

    }

    
}
