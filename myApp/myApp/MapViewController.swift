//
//  MapViewController.swift
//  myApp
//
//  Created by Omar Wasim on 7/12/17.
//  Copyright © 2017 Make School. All rights reserved.
//
import UIKit
import GoogleMaps
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    var resultsOnMap = [Restaurant]()
    
    var markerName = ""
    
    var restaurantLongitude = 0.0
    var restaurantLatitude = 0.0
    
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    
    var mapView: GMSMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 50
//        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        
        
        let camera = GMSCameraPosition.camera(withLatitude: resultsOnMap[0].latitude, longitude:resultsOnMap[0].longitude, zoom: 13)
        mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        print(resultsOnMap.count)
        
        for result in resultsOnMap{
            navigationItem.title = markerName
            
            let restaurantLocation = CLLocationCoordinate2D(latitude: result.latitude, longitude: result.longitude)
            let marker = GMSMarker(position: restaurantLocation)
            marker.title = result.name
            marker.map = mapView
            
            view = mapView
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
        let camera = GMSCameraPosition.camera(withLatitude: (currentLocation?.coordinate.latitude)!, longitude:(currentLocation?.coordinate.longitude)!, zoom: 13)
        mapView.camera = camera
        
        
        print("Lat: \(currentLocation?.coordinate.latitude), Lon: \(currentLocation?.coordinate.longitude)")
        locationManager.stopUpdatingLocation()
    }
    
}
