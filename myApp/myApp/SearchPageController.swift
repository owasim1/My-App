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

class SearchPageController: UIViewController, CLLocationManagerDelegate, UITextFieldDelegate {
    
    let locationManager = CLLocationManager()
    
    var locValue: CLLocation?
    
    var restaurants = [Restaurant]()
    
    var restaurantsMenuCategoryItems = [MenuItem!]()
    
    var trimmedString: String = ""
    
    @IBOutlet weak var loadingDataIndicator: UIActivityIndicatorView!
    
    
    @IBOutlet weak var budgetTextField: UITextField!
    
    @IBAction func budgetTextFieldFull(_ sender: Any) {
    }
    
    @IBOutlet weak var foodItemTextField: UITextField!
    
    @IBOutlet weak var findButton: UIButton!
    
    @IBAction func findButtonTapped(_ sender: Any) {
        
        if Double(budgetTextField.text!) == nil{
            let alertMinBudget = UIAlertController(title: "Oops!", message: "Please enter a valid budget.", preferredStyle: UIAlertControllerStyle.alert)
            alertMinBudget.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alertMinBudget, animated: true, completion: nil)
        }
        else{
            if Double(budgetTextField.text!) == 0 {
                let alertMinBudget = UIAlertController(title: "Oops!", message: "You need to enter a value over $0.", preferredStyle: UIAlertControllerStyle.alert)
                alertMinBudget.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alertMinBudget, animated: true, completion: nil)
            }
            else{
                findButton.isUserInteractionEnabled = false
                
                loadingDataIndicator.isHidden = false
                loadingDataIndicator.startAnimating()
                self.navigationController?.isNavigationBarHidden = true
                loadScreenView.isHidden = false
                
                getFinalResults { (didComplete) in
                    if didComplete
                    {
                        self.loadingDataIndicator.isHidden = true
                        self.loadScreenView.isHidden = true
                        self.performSegue(withIdentifier: "toResultsPage", sender: self)
                    }
                }
            }
        }
    }
    
    @IBOutlet weak var loadScreenView: UIView!
    
    @IBAction func unwindToSearchScreenFromResults(_ segue: UIStoryboardSegue) {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "toResultsPage"
        {
            let destinationController = segue.destination as! ResultsController
            
            destinationController.results = restaurants
            destinationController.preferredType = trimmedString.lowercased()
            destinationController.currentLocation = locValue
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        moveTextField(textField: foodItemTextField, moveDistance: -35, up: true)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        moveTextField(textField: foodItemTextField, moveDistance: -35, up: false)
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func moveTextField(textField: UITextField, moveDistance: Int, up: Bool){
        let moveDuration = 0.3
        let movement = CGFloat(up ? moveDistance : -moveDistance)
        
        UIView.beginAnimations("animateTextField", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(moveDuration)
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        foodItemTextField.delegate = self
        
        loadScreenView.isHidden = true
        
        self.navigationController?.isNavigationBarHidden = true
        
        findButton.layer.cornerRadius = 5
        findButton.layer.borderWidth = 0
        findButton.layer.borderColor = UIColor.clear.cgColor
        
        self.hideKeyboard()
        
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled()
        {
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        loadingDataIndicator.isHidden = true
        
        foodItemTextField.addTarget(self, action: #selector(SearchPageController.textFieldDidChange(textField:)), for: .editingChanged)
    }
    
    func textFieldDidChange(textField: UITextField)
    {
        textField.text = textField.text!.replacingOccurrences(of: " ", with: "")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        if let managerLocation = manager.location
        {
            locValue = managerLocation
        }
        else
        {
            print("failed to update current location")
        }
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        findButton.isUserInteractionEnabled = true
    }

    func getFinalResults(completionHandler: @escaping (Bool) -> Void) {

        budgetTextField.keyboardType = UIKeyboardType.numberPad

        let dispatchGroup = DispatchGroup()
        
        if let currentLocation = locValue
        {
            APIManager.getRestaurants(forCoordinates: currentLocation.coordinate) { (allRestaurantsJSON) in
                
                var restaurantsArray = [Restaurant]()
                
                //loop through the restaurants json array
                for index in 0..<allRestaurantsJSON.count {
                    dispatchGroup.enter()
                    
                    let restaurantKey = allRestaurantsJSON[index]["apiKey"].stringValue
                    
                    self.trimmedString = self.foodItemTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                    
                    APIManager.getMenuCategories(forRestaurantKey: restaurantKey, underBudget: Double(self.budgetTextField.text!)!, foodType: self.trimmedString, completionHandler: { (menuCategories) in
                        
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
    
}

extension SearchPageController{
    
    func hideKeyboard(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(SearchPageController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard(){
        view.endEditing(true)
    }
}
