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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let camera = GMSCameraPosition.camera(withLatitude: resultsOnMap[0].latitude, longitude:resultsOnMap[0].longitude, zoom: 13)
        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
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
}


    
