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
    
    
    var restaurants = [Restaurant]() {
        didSet {
            print("Works!!!")
        }
    }
    
    var restaurantsMenuCategoryItems = [MenuItem!]()
    
    @IBAction func findButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "toResultsPage", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "toResultsPage"
        {
            let destinationController = segue.destination as! ResultsController
            
            destinationController.results = restaurants
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getFinalResults()
        

    
    }
    
    func getFinalResults() {
        
        
        
        budgetTextField.keyboardType = UIKeyboardType.numberPad
        
        let coordinates = CLLocationCoordinate2D(latitude: 37.773387, longitude: -122.417622)
   
        let dispatchGroup = DispatchGroup()
        APIManager.getRestaurants(forCoordinates: coordinates) { (allRestaurantsJSON) in
            //            self.restaurants = allRestaurants
            
            var restaurantsArray = [Restaurant]()
            
            
            //loop through the restaurants json array
            for index in 0..<allRestaurantsJSON.count {
                dispatchGroup.enter()
                let restaurantKey = allRestaurantsJSON[index]["apiKey"].stringValue
                

                
                APIManager.getMenuCategories(forRestaurantKey: restaurantKey, underBudget: 2.00, completionHandler: { (menuCategories) in
                    
                    
                    outerloop: for menuCategory in menuCategories{
                        if menuCategory.name != "" {
                            let restaurant = Restaurant(json: allRestaurantsJSON[index])
                            restaurant?.menuCategories.append(menuCategory)
                            restaurantsArray.append(restaurant!)
                            break outerloop
                            //if at least one menu category is not empty, it is enough, we have to create a restaurant, so quit the category loop, and go check next restaurant
                            
                        }
                    }
                    
                    dispatchGroup.leave()

                })
            }
            
            
            
            dispatchGroup.notify(queue: .main, execute: { 
                self.restaurants = restaurantsArray
            })
 
        }
        
        
    }
    
}



