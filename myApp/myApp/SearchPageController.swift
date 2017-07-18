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
    let apiKey = "485ca34bedf9153e76b021c02816a79ae41ee9406039e889"
    let baseSearchURL = "https://api.eatstreet.com/publicapi/v1/restaurant/search"
    
    @IBAction func budgetTextFieldUsed(_ sender: Any) {
        
        var searchText = budgetTextField.text

        
    }
    
    @IBOutlet weak var budgetTextField: UITextField!
    
    @IBOutlet weak var foodItemTextField: UITextField!
    
    @IBOutlet weak var findButton: UIButton!
    
    @IBAction func findButtonTapped(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        budgetTextField.keyboardType = UIKeyboardType.numberPad
        
        let headers: HTTPHeaders = ["X-Access-Token": self.apiToken]
        
        let params: Parameters = ["street-address" : "Mission Street, San Fransisco", "method": "both"]
        Alamofire.request(self.baseSearchURL, method: .get, parameters: params, encoding: URLEncoding.default, headers: headers).responseData { (response) in
            let json = JSON(with: response.data!)
            print(json)
            if let restaurants = json["restaurants"].array {
                for restaurant in restaurants {
                    if let apiKey = restaurant["apiKey"].string {
                        
                        Alamofire.request("https://api.eatstreet.com/publicapi/v1/restaurant/\(apiKey)/menu", method: .get, parameters: params, encoding: URLEncoding.default, headers: headers).responseData { (response) in
                            let json2 = JSON(with: response.data!)
                            print(json2)
                            
                        }
                        
                    }
                }
            }
        }
}
}

