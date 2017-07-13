//
//  ResultsController.swift
//  myApp
//
//  Created by Omar Wasim on 7/10/17.
//  Copyright © 2017 Make School. All rights reserved.
//

import UIKit

class ResultsController: UITableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultsTableViewCell", for: indexPath) as! ResultsTableViewCell
        

        cell.nameOfRestaurantLabel.text = "name of restuarant"
        cell.restaurantTypeLabel.text = "restaurant type"
        cell.distanceLabel.text = "distance"
        
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
