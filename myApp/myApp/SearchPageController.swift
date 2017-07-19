//
//  SearchPageController.swift
//  myApp
//
//  Created by Omar Wasim on 7/10/17.
//  Copyright © 2017 Make School. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SearchPageController: UIViewController {
    
    let apiToken = "11443211f14e75a5"
    
    let baseSearchURL = "https://api.eatstreet.com/publicapi/v1/restaurant/search"
    

    
    
    
    
    @IBOutlet weak var budgetTextField: UITextField!
    
    @IBAction func budgetTextFieldFull(_ sender: Any) {
        print("your budget")
        
    }
    
    @IBOutlet weak var foodItemTextField: UITextField!
    
    @IBOutlet weak var findButton: UIButton!
    
    
    var restaurants = [Restaurant]()
    
    var restaurantsMenuCategoryItems = [MenuItem!]()
    
    @IBAction func findButtonTapped(_ sender: Any) {
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        budgetTextField.keyboardType = UIKeyboardType.numberPad
        
        let headers: HTTPHeaders = ["X-Access-Token": self.apiToken]
        
        let params: Parameters = ["street-address" : "Make School, San Fransisco", "method": "both"]
        
        APIManager.getRestaurants(withURL: baseSearchURL, parameters: params, headers: headers) { (restaurants) in
            
            self.restaurants = restaurants
            
            //revise High Order Functions Homework
            let restaurantKeys = restaurants.map{ $0.key }

            //index is 0 to number of restaurant keys\restaurants
            for index in 0..<restaurantKeys.count {
                //each restaurant key is used to get menuCategories of each restaurant menu
                APIManager.getMenuCategories(forKey: restaurantKeys[index], headers: headers, completionHandler: { (menuCategories) in
                    
                    //each menu category of each restaurant's menu is stored in menuCategories property of restaurants
                    restaurants[index].menuCategories = menuCategories
                    print()
                    print(restaurants[index].name)
                    print()
                    //index is 0 to number of menuCategories for each restaurant
                    for categoryIndex in 0..<restaurants[index].menuCategories!.count{
                        print()
                        print(restaurants[index].menuCategories![categoryIndex].name)
                        print()
                        //index is 0 to number of items in the category
                        for itemIndex in 0..<restaurants[index].menuCategories![categoryIndex].items!.count{
                            //assigning each item in category to restaurantsMenuCategoryItem of type [MenuItem]
                            self.restaurantsMenuCategoryItems = [restaurants[index].menuCategories?[categoryIndex].items![itemIndex]]
                            print("\(self.restaurantsMenuCategoryItems[0].name) \(self.restaurantsMenuCategoryItems[0].price)")
                        }
                    }
                })
            }
            
            print("Do something with restaurant keys")
        }
    }
}

