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
import Darwin

var dist1 = 0.0
var dir1 = 0.0
var destlat = 0.0
var destlng = 0.0


class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    @IBOutlet weak var arr1: UIImageView!
    @IBOutlet weak var DirectionLabel: UILabel!
    
    @IBOutlet weak var loclabel: UILabel!
    
    @IBOutlet weak var maplabel: UILabel!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var slider1: UISlider!
    @IBOutlet weak var newarr: UIImageView!
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
        
        if(self.DirectionLabel != nil){
            self.DirectionLabel.hidden = true
            self.label1.hidden = true
            self.newarr.hidden = true
        }
        
    }

       override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        
        self.getdir(manager.location)
        self.getdist(manager.location)
        if(self.loclabel != nil){
            self.loclabel.text = "Altitude: \(round(manager.location.altitude*3.28))"
            self.label1.text = "Distance: \(round(dist1*3.28084)) ft."
            self.DirectionLabel.text = "Heading: \(round(dir1*100.0)/100.0) deg."
        }else if(self.maplabel != nil){
            self.getdest()
            self.getdir(manager.location)
            self.getdist(manager.location)
            self.maplabel.text = "\(round(dist1*3.28084)) ft."
        }
        
        
//        CLGeocoder().reverseGeocodeLocation(manager.location, completionHandler: {(placemarks, error) -> Void in
//
//            if(error != nil){
//                println("ERROR:" + error.localizedDescription)
//                return
//            }
//            if(placemarks.count > 0){
//                let pm = placemarks[0] as CLPlacemark
//                //self.displayLocationInfo(pm)
//            }else{
//                println("Error with data")
//            }
//            
//        })
        
    }
    
//    func MapManager(manager: MKMapViewDelegate!, mapViewWillStartRenderingMap locations: [AnyObject]!){
//        if(self.locationManager.location != nil && self.maplabel != nil){
//            self.getdist(self.locationManager.location)
//            self.maplabel.text = "\(round((dist1*3.28)/52.8)/100.0) mi."
//        }
//        
//    }
    
    
//    func displayLocationInfo(placemark: CLPlacemark) {
//        //once we have location, stop getting location to save battery
//        self.locationManager.stopUpdatingLocation()
//        println(placemark.locality)
//        println(placemark.postalCode)
//        println(placemark.administrativeArea)
//        println(placemark.country)
//    }

    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!){
            println("Error" + error.localizedDescription)
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateHeading newHeading: CLHeading!) {
        
        if(destlat != 0 && self.label1 != nil){
            self.DirectionLabel.hidden = false
            self.label1.hidden = false
            self.newarr.hidden = false
        }
        
        if(self.newarr != nil){
            var dirfin = newHeading.trueHeading + dir1
            if (dirfin > 360.0){
                dirfin = dirfin - 360.0
            }
            newarr.transform=CGAffineTransformMakeRotation(-(CGFloat(dirfin * (M_PI / 180.0))))
            arr1.transform=CGAffineTransformMakeRotation(-(CGFloat(newHeading.trueHeading * (M_PI / 180.0))))
            //DirectionLabel.text="Heading: \(round(self.locationManager.heading.trueHeading))"
        }
        
        if(self.locationManager.location != nil && self.maplabel != nil){
            getdest()
            getdir(manager.location)
            getdist(manager.location)
            self.maplabel.text = "\(round(dist1*3.28084)) ft."
        }
        if(self.locationManager.location != nil && self.label1 != nil){
            getdir(manager.location)
            getdist(manager.location)
            self.label1.text = "Distance: \(round(dist1*3.28084)) ft."
            self.DirectionLabel.text = "Heading: \(round(dir1*100.0)/100.0) deg."
            
        }
        
        
    }
    
    
    func number(x: NSInteger) -> NSInteger {
        return x*x
    }
    
    
    
    @IBAction func slid(sender: AnyObject) {
        label1.text = "\(round(slider1.value*20.0)) ft"
        arr1.transform = CGAffineTransformMakeRotation(CGFloat(slider1.value)*5)
        arr1.layer.shouldRasterize = true
    }

    func getdest() {
        var center = mymap.centerCoordinate as CLLocationCoordinate2D
        var getLat: CLLocationDegrees = center.latitude
        var getLon: CLLocationDegrees = center.longitude
        destlat = getLat
        destlng = getLon
    }
    func getdist(myloc: CLLocation) {
        var destloc: CLLocation =  CLLocation(latitude: destlat, longitude: destlng)
        dist1 = myloc.distanceFromLocation(destloc) as Double
    }
    func getdir(myloc: CLLocation) {
        var lat1rad = myloc.coordinate.latitude * (M_PI/180.0)
        var lng1rad = myloc.coordinate.longitude * (M_PI/180.0)
        
        var lat2rad = destlat * (M_PI/180.0)
        var lng2rad = destlng * (M_PI/180.0)
        
        var dir0 = atan2(sin(lng1rad-lng2rad)*cos(lat2rad), cos(lat1rad)*sin(lat2rad)-sin(lat1rad)*cos(lat2rad)*cos(lng1rad-lng2rad))*(180.0/M_PI)
        if (dir0 < 0.0){
            dir0 = dir0 + 360.0
        }
        dir1 = dir0
    }
}