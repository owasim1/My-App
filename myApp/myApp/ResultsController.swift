//
//  ResultsController.swift
//  myApp
//
//  Created by Omar Wasim on 7/10/17.
//  Copyright © 2017 Make School. All rights reserved.
//

import UIKit

class ResultsController: UITableViewController {
    
    var results = [Result]()
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultsTableViewCell", for: indexPath) as! ResultsTableViewCell
        
        let row = indexPath.row
        
        let result = results[row]
        
        cell.nameOfRestaurantLabel.text = result.nameOfRestaurant
        cell.restaurantTypeLabel.text = result.restaurantType
        cell.distanceLabel.text = result.distance
        
        
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
