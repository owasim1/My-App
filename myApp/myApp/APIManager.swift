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

class APIManager {
    
    static func getRestaurants(withURL url: String, parameters: Parameters, headers: HTTPHeaders,  completionHandler: @escaping ([Restaurant]) -> Void) {
        
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseData { (response) in
            let json = JSON(with: response.data!)
            
            if let restaurantsJSON = json["restaurants"].array {
                
                
                //create array for keys
                var restaurantKeysArray = [String]()
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
    
    static func getMenuCategories(forKey key: String, headers: HTTPHeaders, completionHandler: @escaping ([MenuCategory]) -> Void) {
        
        var url = ""
        

        url = "https://api.eatstreet.com/publicapi/v1/restaurant/\(key)/menu"

        Alamofire.request(url, method: .get, encoding: URLEncoding.default, headers: headers).responseData(completionHandler: { (response) in
            let json = JSON(with: response.data!)
            guard let menuCategoriesJSON = json.array else {
                completionHandler([])
                return
            }
            
            var menuCategories = [MenuCategory]()

            for menuCategoryJSON in menuCategoriesJSON {
                if let menuCategory = MenuCategory(json: menuCategoryJSON) {
                    menuCategories.append(menuCategory)
                }
            }
            
            completionHandler(menuCategories)
            
        })

    }

    
}
