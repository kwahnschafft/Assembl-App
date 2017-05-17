//
//  DetailViewController.swift
//  SwiftDatabaseTutorial
//
//  Created by Kiara Wahnschafft on 3/3/17.
//  Copyright © 2017 Kiara. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class DetailViewController : UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var selectedLocation : LocationModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Create coordinates from location lat/long
        var poiCoodinates: CLLocationCoordinate2D = CLLocationCoordinate2D()
        
        
        if(self.selectedLocation != nil) {
            poiCoodinates.latitude = CDouble(self.selectedLocation!.latitude!)!
            poiCoodinates.longitude = CDouble(self.selectedLocation!.longitude!)!
            
            // Zoom to region
            let viewRegion: MKCoordinateRegion = MKCoordinateRegionMakeWithDistance(poiCoodinates, 750, 750)
            self.mapView.setRegion(viewRegion, animated: true)
            // Plot pin
            let pin: MKPointAnnotation = MKPointAnnotation()
            pin.coordinate = poiCoodinates
            self.mapView.addAnnotation(pin)
            
            //add title to the pin
            pin.title = selectedLocation!.name
        }
    
            


        
    
        
    }
    
}
