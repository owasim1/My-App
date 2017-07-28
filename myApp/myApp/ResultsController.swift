//
//  ResultsController.swift
//  myApp
//
//  Created by Omar Wasim on 7/10/17.
//  Copyright © 2017 Make School. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class ResultsController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var results = [Restaurant]()
    var restaurantName: String = ""
    
    var selectedRestaurant : Restaurant?
    
    var preferredType: String! = ""
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var resultsAndMapViewSwitch: UISegmentedControl!
    
    @IBAction func unwindToResultsController(segue: UIStoryboardSegue){
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toTheRestaurantMenu" {
            let destinationController = segue.destination as! DisplayRestaurantMenuController
            destinationController.restaurant = selectedRestaurant
            destinationController.restuarantTitle = restaurantName
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if preferredType != ""{
            return results.filter({$0.foodType!.contains(preferredType)}).count
        }
        else{
            return results.count
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        if preferredType != ""{
            selectedRestaurant = results.filter({$0.foodType!.contains(preferredType)})[indexPath.row]
        }
        else{
            selectedRestaurant = results[indexPath.row]
        }
        
        
        restaurantName = results.filter({$0.foodType!.contains(preferredType)})[indexPath.row].name
        performSegue(withIdentifier: "toTheRestaurantMenu", sender: self)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultsTableViewCell", for: indexPath) as! ResultsTableViewCell
        
        let row = indexPath.row
        
        let result: Restaurant
        
        if preferredType != ""{
            result = results.filter({$0.foodType!.contains(preferredType)})[row]
        }
        else{
            result = results[row]
        }
        
        cell.nameOfRestaurantLabel.text = result.name
        cell.restaurantTypeLabel.text = result.restaurantType
        cell.distanceLabel.text = String(result.distance)
        
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(selectedRestaurant?.foodType ?? "")
    }
}
