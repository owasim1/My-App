//
//  MapViewController.swift
//  myApp
//
//  Created by Omar Wasim on 7/12/17.
//  Copyright © 2017 Make School. All rights reserved.
//
import UIKit
import GoogleMaps

class MapViewController: UIViewController {
    
    var markerName = ""
    
    var restaurantLongitude = 0.0
    var restaurantLatitude = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = markerName
        
        let camera = GMSCameraPosition.camera(withLatitude: restaurantLatitude, longitude: restaurantLongitude, zoom: 10)
        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        
        let restaurantLocation = CLLocationCoordinate2D(latitude: 33.3, longitude: -122)
        let marker = GMSMarker(position: restaurantLocation)
        marker.position = camera.target
        marker.title = markerName
        marker.map = mapView
        
        view = mapView
        
    }
}
    
