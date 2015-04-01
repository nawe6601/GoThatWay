//
//  ViewController.swift
//  GoThatWay
//
//  Created by Pair Programming on 2/23/15.
//  Copyright (c) 2015 JSAHN. All rights reserved.
//



import UIKit
import CoreMotion
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.locationManager.delegate = self
        if (CLLocationManager.locationServicesEnabled()) {
            self.locationManager.requestWhenInUseAuthorization()
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
            self.locationManager.startUpdatingLocation()
        }
        // Start heading updates.
        if (CLLocationManager.headingAvailable()) {
            self.locationManager.headingFilter = 1;
            self.locationManager.startUpdatingHeading()
        }
        
    }

       override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBOutlet weak var arr1: UIImageView!
    @IBOutlet weak var DirectionLabel: UILabel!
    
    @IBOutlet weak var loclabel: UILabel!
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        CLGeocoder().reverseGeocodeLocation(manager.location, completionHandler: {(placemarks, error) -> Void in
            
            if(error != nil){
                println("ERROR:" + error.localizedDescription)
                return
            }
            if(placemarks.count > 0){
                let pm = placemarks[0] as CLPlacemark
                //self.displayLocationInfo(pm)
            }else{
                println("Error with data")
            }
            
        })
        loclabel.text = "Altitude: \(round(manager.location.altitude*3.28))"
    }
    
    func displayLocationInfo(placemark: CLPlacemark) {
        //once we have location, stop getting location to save battery
        self.locationManager.stopUpdatingLocation()
        println(placemark.locality)
        println(placemark.postalCode)
        println(placemark.administrativeArea)
        println(placemark.country)
    }

    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!){
            println("Error" + error.localizedDescription)
        
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateHeading newHeading: CLHeading!) {
        arr1.transform=CGAffineTransformMakeRotation(-((CGFloat(newHeading.trueHeading)/180.0)*3.14))
        DirectionLabel.text="Heading: \(round(self.locationManager.heading.trueHeading))"
        
    }
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var slider1: UISlider!
    
    @IBAction func slid(sender: AnyObject) {
        label1.text = "\(round(slider1.value*20)) ft"
        arr1.transform = CGAffineTransformMakeRotation(CGFloat(slider1.value)*5)
        arr1.layer.shouldRasterize = true
    }
  
}

