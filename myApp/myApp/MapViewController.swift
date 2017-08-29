//
//  MapViewController.swift
//  myApp
//
//  Created by Omar Wasim on 7/12/17.
//  Copyright © 2017 Make School. All rights reserved.
//
import UIKit
import Alamofire
import SwiftyJSON
import GoogleMaps
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    var restaurantData = Dictionary<String, Any>()
    
    var resultsOnMap = [Restaurant]()
    
    var markerName = ""
    
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    
    var mapView: GMSMapView!
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "unwindFromMap", sender: self)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 50
        locationManager.delegate = self
        
        let camera = GMSCameraPosition.camera(withLatitude: resultsOnMap[0].latitude, longitude:resultsOnMap[0].longitude, zoom: 13)
        mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        
        for result in resultsOnMap{
            if resultsOnMap.count == 1 {
                navigationItem.title = markerName
            }
            else{
                navigationItem.title = "All Restaurants"
            }
            let restaurantLocation = CLLocationCoordinate2D(latitude: result.latitude, longitude: result.longitude)
            let marker = GMSMarker(position: restaurantLocation)
            marker.title = result.name
            restaurantData["streetAddress"] = result.streetAddress
            marker.userData = restaurantData
            marker.map = self.mapView
            
            view = self.mapView
        }

    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            locationManager.startUpdatingLocation()
            mapView.isMyLocationEnabled = true
            mapView.settings.myLocationButton = true
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let lastUpdatedLocation = locations.last
        currentLocation = lastUpdatedLocation
        locationManager.stopUpdatingLocation()
    }
    
}
