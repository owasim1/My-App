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
    
    @IBOutlet weak var foodItemTextField: UITextField!
    
    @IBOutlet weak var findButton: UIButton!
    
    
    var restaurants = [Restaurant]()
    
    @IBAction func findButtonTapped(_ sender: Any) {
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        budgetTextField.keyboardType = UIKeyboardType.numberPad
        
        let headers: HTTPHeaders = ["X-Access-Token": self.apiToken]
        
        let params: Parameters = ["street-address" : "Mission Street, San Fransisco", "method": "both"]
        
        APIManager.getRestaurants(withURL: baseSearchURL, parameters: params, headers: headers) { (restaurants) in
            
            self.restaurants = restaurants
            
            //revise High Order Functions Homework
            let restaurantKeys = restaurants.map{ $0.key }

            
            for index in 0..<restaurantKeys.count {
                APIManager.getMenuCategories(forKey: restaurantKeys[index], headers: headers, completionHandler: { (menuCategories) in
                    
                    restaurants[index].menuCategories = menuCategories
                })
            }

            
            print("Do something with restaurant keys")
        }
        
        print("keep going")
        print("keep going here")
        
        

    }
}

