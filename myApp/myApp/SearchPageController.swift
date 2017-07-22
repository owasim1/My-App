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
    }
    
    @IBOutlet weak var foodItemTextField: UITextField!
    
    @IBOutlet weak var findButton: UIButton!
    
    
    var restaurants = [Restaurant]()
    
    var restaurantsMenuCategoryItems = [MenuItem!]()
    
    @IBAction func findButtonTapped(_ sender: Any) {

        findButton.isUserInteractionEnabled = false
        
        getFinalResults { (didComplete) in
            if didComplete
            {
                self.performSegue(withIdentifier: "toResultsPage", sender: self)
            }
        }
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
            
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        findButton.isUserInteractionEnabled = true
    }

    func getFinalResults(completionHandler: @escaping (Bool) -> Void) {

        budgetTextField.keyboardType = UIKeyboardType.numberPad
        
        let coordinates = CLLocationCoordinate2D(latitude: 40.7128, longitude: 74.0059)
        
        let dispatchGroup = DispatchGroup()
        APIManager.getRestaurants(forCoordinates: coordinates) { (allRestaurantsJSON) in
            //            self.restaurants = allRestaurants
            
            var restaurantsArray = [Restaurant]()

            //loop through the restaurants json array
            for index in 0..<allRestaurantsJSON.count {
                dispatchGroup.enter()
                
                let restaurantKey = allRestaurantsJSON[index]["apiKey"].stringValue
                
                APIManager.getMenuCategories(forRestaurantKey: restaurantKey, underBudget: Double(self.budgetTextField.text!)!, completionHandler: { (menuCategories) in
                    
                    
                    for menuCategory in menuCategories {
                        if menuCategory.name != "" {

                            if restaurantsArray.map({ $0.key }).contains(where: { $0 == restaurantKey }) == true {
                                let existingRestaurant = restaurantsArray[restaurantsArray.count - 1]
                                existingRestaurant.menuCategories.append(menuCategory)
                                restaurantsArray[restaurantsArray.count-1] = existingRestaurant
                            } else {
                                let restaurant = Restaurant(json: allRestaurantsJSON[index])
                                restaurant?.menuCategories.append(menuCategory)
                                restaurantsArray.append(restaurant!)
                            }
                        }
                    }
                    
                    dispatchGroup.leave()
                })
                
            }
            
            dispatchGroup.notify(queue: .main, execute: {
                self.restaurants = restaurantsArray
                completionHandler(true)
            })
            
        }
        
        
    }
    
}



