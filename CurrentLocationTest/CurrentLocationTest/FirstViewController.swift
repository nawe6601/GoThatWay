//
//  FirstViewController.swift
//  CurrentLocationTest
//
//  Created by Henrik Larsen on 3/4/15.
//  Copyright (c) 2015 Henrik Larsen. All rights reserved.
//


import UIKit
import MapKit
import CoreLocation


class FirstViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var map: MKMapView!
    let locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //When use in forground
        self.locationManager.requestWhenInUseAuthorization()
        
        //When use in background
        self.locationManager.requestAlwaysAuthorization()
        
        if (CLLocationManager.locationServicesEnabled())
        {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        var locValue:CLLocationCoordinate2D = manager.location.coordinate
        
        println("locations = \(locValue.latitude) \(locValue.longitude)")
        
        let center = CLLocationCoordinate2D(latitude: locValue.latitude, longitude: locValue.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        self.map.setRegion(region, animated: true)
        var currentLocation = CLLocation()
        
        var locationLat = currentLocation.coordinate.latitude
        var locationLong = currentLocation.coordinate.longitude
        
        println("locations = \(locationLat) \(locationLong)\(currentLocation.coordinate.latitude)\(currentLocation.coordinate.longitude)")
        
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println("Error while updating location " + error.localizedDescription)
    }
    
    func locationManagerDidPauseLocationUpdates(manager: CLLocationManager!) {
        //
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}

