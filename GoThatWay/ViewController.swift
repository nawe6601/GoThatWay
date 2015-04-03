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
import MapKit

var dist1 = 0.0;


class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    @IBOutlet weak var arr1: UIImageView!
    @IBOutlet weak var DirectionLabel: UILabel!
    
    @IBOutlet weak var loclabel: UILabel!
    
    @IBOutlet weak var maplabel: UILabel!

    @IBOutlet weak var mymap: MKMapView!
    let locationManager = CLLocationManager()
    var myloc = CLLocation()
    
    
    
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
        
        if(self.locationManager.location != nil && self.maplabel != nil){
            let region = MKCoordinateRegionMakeWithDistance(self.locationManager.location.coordinate, 2000, 2000)
            self.mymap.setRegion(region, animated: true)
        }
        
    }

       override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        CLGeocoder().reverseGeocodeLocation(manager.location, completionHandler: {(placemarks, error) -> Void in

            if(error != nil){
                println("ERROR:" + error.localizedDescription)
                return
            }
            if(placemarks.count > 0){
                let pm = placemarks[0] as CLPlacemark
                //self.displayLocationInfo(pm)
                if(self.loclabel != nil){
                    self.loclabel.text = "Altitude: \(round(manager.location.altitude*3.28))"
                    self.label1.text = "\(round(dist1))"
                }else{
                    dist1 = self.domapstuff(manager.location)
                    self.maplabel.text = "\(round((dist1*3.28)/52.8)/100.0) mi."
                }
                
            }else{
                println("Error with data")
            }
            
        })
        
    }
    
    func MapManager(manager: MKMapViewDelegate!, mapViewWillStartRenderingMap locations: [AnyObject]!){
        if(self.locationManager.location != nil && self.maplabel != nil){
            dist1 = self.domapstuff(self.locationManager.location)
            self.maplabel.text = "\(round((dist1*3.28)/52.8)/100.0) mi."
        }
        
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
        
        if(arr1 != nil){
        arr1.transform=CGAffineTransformMakeRotation(-((CGFloat(newHeading.trueHeading)/180.0)*3.14))
        DirectionLabel.text="Heading: \(round(self.locationManager.heading.trueHeading))"
        }
        
        if(self.locationManager.location != nil && self.maplabel != nil){
            dist1 = self.domapstuff(manager.location)
            self.maplabel.text = "\(round((dist1*3.28)/52.8)/100.0) mi."
        }
        
    }
    
    
    func number(x: NSInteger) -> NSInteger {
        return x*x
    }
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var slider1: UISlider!
    
    @IBAction func slid(sender: AnyObject) {
        label1.text = "\(round(slider1.value*20)) ft"
        arr1.transform = CGAffineTransformMakeRotation(CGFloat(slider1.value)*5)
        arr1.layer.shouldRasterize = true
    }

    func domapstuff(myloc: CLLocation) -> Double {
        var center = mymap.centerCoordinate as CLLocationCoordinate2D
        var getLat: CLLocationDegrees = center.latitude
        var getLon: CLLocationDegrees = center.longitude
        var getMovedMapCenter: CLLocation =  CLLocation(latitude: getLat, longitude: getLon)
        return myloc.distanceFromLocation(getMovedMapCenter) as Double
    }
  
}


//class ViewController2: UIViewController, MKMapViewDelegate {
//    
//    @IBOutlet weak var mymap: MKMapView!
//    let locationManager = CLLocationManager()
//    
//    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
//
//    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//
//    func domapstuff(didupdatemap myloc: CLLocation) -> Double {
//        var center = mymap.centerCoordinate as CLLocationCoordinate2D
//        var getLat: CLLocationDegrees = center.latitude
//        var getLon: CLLocationDegrees = center.longitude
//        var getMovedMapCenter: CLLocation =  CLLocation(latitude: getLat, longitude: getLon)
//        
//        return myloc.distanceFromLocation(getMovedMapCenter) as Double
//    }
//}