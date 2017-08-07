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
    
    @IBOutlet weak var noResultsStack: UIStackView!
    
    @IBOutlet weak var noResultsImage: UIImageView!
    
    @IBOutlet weak var takeMeBackButton: UIButton!
    
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
        
        return filteredResults.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {

        selectedRestaurant = filteredResults[indexPath.row]
        restaurantName = filteredResults[indexPath.row].name
        
        performSegue(withIdentifier: "toTheRestaurantMenu", sender: self)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultsTableViewCell", for: indexPath) as! ResultsTableViewCell
        
        let row = indexPath.row
        
        let result: Restaurant

        result = filteredResults[row]
        
        

        let distanceInMiles = result.distance * 0.000621371
        
        if let lowerBound = result.name.range(of: "-")?.lowerBound {
            result.name = result.name.substring(to: lowerBound)
        }
        
        cell.nameOfRestaurantLabel.text = result.name
        cell.distanceLabel?.text = "\(distanceInMiles.truncate(places: 1)) miles"
        cell.restaurantAddress.text = "\(result.streetAddress), \(result.city)"
        
        cell.accessoryType = .disclosureIndicator
        cell.accessoryView = UIImageView(image: #imageLiteral(resourceName: "front_arrow (2)"))
        cell.tintColor = UIColor(red: 190.0/255.0, green: 30.0/255.0, blue: 45.0/255.0, alpha: 1.0)
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        
        noResultsImage.isHidden = true
        noResultsStack.isHidden = true
        takeMeBackButton.isHidden = true
        takeMeBackButton.isUserInteractionEnabled = false
        
        
        
        
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
            filteredResults = filteredRestaurants
        }
        
        else{
            filteredResults = results
            
        }
        
        for result in filteredResults{
            let restaurantCoordinate = CLLocation(latitude: result.latitude, longitude: result.longitude)
            result.distance = Double(restaurantCoordinate.distance(from: currentLocation!))

        }
        
        filteredResults = filteredResults.sorted{ $0.distance < $1.distance }
        
        cellCount = filteredResults.count


        if cellCount == 0{
            self.navigationController?.isNavigationBarHidden = true
            tableView.isHidden = true
            mapButton.isEnabled = false
            mapButton.accessibilityElementsHidden = true
            noResultsImage.isHidden = false
            noResultsStack.isHidden = false
            takeMeBackButton.isHidden = false
            takeMeBackButton.isUserInteractionEnabled = true
        }
        else{
            self.navigationController?.isNavigationBarHidden = false
            tableView.isHidden = false
            noResultsImage.isHidden = true
            noResultsStack.isHidden = true
            takeMeBackButton.isHidden = true
            takeMeBackButton.isUserInteractionEnabled = false
            mapButton.isEnabled = true
            mapButton.accessibilityElementsHidden = false
        }
        
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        takeMeBackButton.layer.cornerRadius = 5
        takeMeBackButton.layer.borderWidth = 0
        takeMeBackButton.layer.borderColor = UIColor.clear.cgColor
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.separatorColor = UIColor(red: 190.0/255.0, green: 30.0/255.0, blue: 45.0/255.0, alpha: 1.0)
        tableView.reloadData()
        
        
        
    }
}


