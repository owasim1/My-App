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
import CoreLocation

class SearchPageController: UIViewController {
    
    
    

    
    
    
    
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
        
        let coordinates = CLLocationCoordinate2D(latitude: 37.773387, longitude: -122.417622)
        
        APIManager.getRestaurants(forCoordinates: coordinates) { (restaurants) in
            self.restaurants = restaurants
            
            //revise High Order Functions Homework
            let restaurantKeys = restaurants.map{ $0.key }
            
            //index is 0 to number of restaurant keys\restaurants
            for index in 0..<restaurantKeys.count {
                //each restaurant key is used to get menuCategories of each restaurant menu
                
                APIManager.getMenuCategories(forRestaurantKey: restaurantKeys[index], underBudget: 5.00, completionHandler: { (menuCategories) in
                    
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



