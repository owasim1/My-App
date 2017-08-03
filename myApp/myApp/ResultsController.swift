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
    
    var preferredType: String!
    
    var filteredResults = [Restaurant]()
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func unwindToResultsController(segue: UIStoryboardSegue){
        
    }
    
    @IBAction func showOnMapPressed(_ sender: Any) {
        performSegue(withIdentifier: "restaurantsToMap", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toTheRestaurantMenu" {
            let destinationController = segue.destination as! DisplayRestaurantMenuController
            destinationController.restaurant = selectedRestaurant
            destinationController.restuarantTitle = restaurantName
        }
        if segue.identifier == "restaurantsToMap"{
            let destinationController = segue.destination as! MapViewController
            destinationController.resultsOnMap = filteredResults
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var filteredRestaurants = [Restaurant]()
        
        if preferredType != ""{
            for a in 0..<results.count{
                for b in 0..<results[a].foodType!.count {
                    if results[a].foodType![b].contains(preferredType) {
                        if !filteredRestaurants.contains(where: {$0.name == results[a].name}){
                            filteredRestaurants.append(results[a])

                        }
                        
                    }
                }
            }
            return filteredRestaurants.count
        }
        else{
            return results.count
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        var filteredRestaurants = [Restaurant]()
        
        if preferredType != "" {
            for a in 0..<results.count{
                for b in 0..<results[a].foodType!.count {
                    if results[a].foodType![b].contains(preferredType) {
                        if !filteredRestaurants.contains(where: {$0.name == results[a].name}){
                            filteredRestaurants.append(results[a])
                            
                        }
                    }
                }
            }
            selectedRestaurant = filteredRestaurants[indexPath.row]
            restaurantName = filteredRestaurants[indexPath.row].name
        }
        else{
            selectedRestaurant = results[indexPath.row]
            restaurantName = results[indexPath.row].name

        }
        
        performSegue(withIdentifier: "toTheRestaurantMenu", sender: self)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultsTableViewCell", for: indexPath) as! ResultsTableViewCell
        
        let row = indexPath.row
        
        let result: Restaurant
        
        var filteredRestaurants = [Restaurant]()
        
        if preferredType != ""{
            for a in 0..<results.count{
                for b in 0..<results[a].foodType!.count {
                    if results[a].foodType![b].contains(preferredType) {
                        if !filteredRestaurants.contains(where: {$0.name == results[a].name}){
                            filteredRestaurants.append(results[a])
                            
                        }
                    }
                }
            }
            result = filteredRestaurants[row]
            filteredResults = filteredRestaurants
        }
        else{
            result = results[row]
            filteredResults = results
        }
        
        cell.nameOfRestaurantLabel.text = result.name
        cell.restaurantTypeLabel.text = result.restaurantType
//        cell.distanceLabel?.text = String(result.distance)
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
