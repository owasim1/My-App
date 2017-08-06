//
//  ResultsController.swift
//  myApp
//
//  Created by Omar Wasim on 7/10/17.
//  Copyright © 2017 Make School. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import CoreLocation
import GoogleMaps

class ResultsController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    
    var mapView : GMSMapView?
    
    var results = [Restaurant]()
    var restaurantName: String = ""
    
    var selectedRestaurant : Restaurant?
    
    var preferredType: String!
    
    var cellCount = 0
    
    var filteredResults = [Restaurant]()
    
    @IBOutlet weak var mapButton: UIBarButtonItem!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var noResultsLabel: UILabel!
    
    @IBOutlet weak var noResultsView: UIView!
    
    @IBAction func unwindToResultsController(segue: UIStoryboardSegue){
        
    }
    
    @IBAction func mapTapped(_ sender: Any) {
        
        performSegue(withIdentifier: "restaurantsToMap", sender: nil)
    }
    
    @IBAction func unwindFromMap(segue:UIStoryboardSegue) {
        
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
            cellCount = filteredRestaurants.count
            return filteredRestaurants.count
        }
        else{
            cellCount = results.count
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
            filteredResults = filteredRestaurants.sorted{ $0.distance < $1.distance }
        }
        else{
            result = results[row]
                        filteredResults = results.sorted{ $0.distance < $1.distance }
        }
        
        let restaurantCoordinate = CLLocation(latitude: result.latitude, longitude: result.longitude)
        result.distance = Int(restaurantCoordinate.distance(from: currentLocation!))

        
        cell.nameOfRestaurantLabel.text = result.name
        cell.distanceLabel?.text = String(result.distance)
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false

//        noResultsView.isHidden = true
//        noResultsLabel.isHidden = true
        if cellCount == 0{
            self.navigationController?.isNavigationBarHidden = true
            tableView.isHidden = true
//            noResultsView.isHidden = false
//            noResultsLabel.isHidden = false
            mapButton.isEnabled = false
            mapButton.accessibilityElementsHidden = true
        }
        else{
            self.navigationController?.isNavigationBarHidden = false
            tableView.isHidden = false
//            noResultsView.isHidden = true
//            noResultsLabel.isHidden = true
            mapButton.isEnabled = true
            mapButton.accessibilityElementsHidden = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        tableView.tableFooterView = UIView(frame: .zero)
    }
}
