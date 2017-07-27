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
    
    @IBOutlet weak var tableView: UITableView!
    
    var selectedRestaurant : Restaurant?
    
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
        return results.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        selectedRestaurant = results[indexPath.row]
        
        
        restaurantName = results[indexPath.row].name
        performSegue(withIdentifier: "toTheRestaurantMenu", sender: self)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultsTableViewCell", for: indexPath) as! ResultsTableViewCell
        
        let row = indexPath.row
        
        let result = results[row]
        
        cell.nameOfRestaurantLabel.text = result.name
        cell.restaurantTypeLabel.text = result.restaurantType
        cell.distanceLabel.text = String(result.distance)
        
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
    }
}
