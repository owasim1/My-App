//
//  appleMapViewController.swift
//  myApp
//
//  Created by Omar Wasim on 7/25/17.
//  Copyright © 2017 Make School. All rights reserved.
//

import UIKit
import MapKit
import GooglePlaces

class appleMapViewController: UIViewController{
    
    var longitude = 0.0
    var latitude = 0.0
    var name = "san fran"
    
    override func viewDidAppear(_ animated: Bool) {
        self.mapView.removeAnnotations(self.mapView.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2DMake(self.latitude, self.longitude)
        annotation.title = self.name
    
        
        self.mapView.addAnnotation(annotation)
        
    }

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
