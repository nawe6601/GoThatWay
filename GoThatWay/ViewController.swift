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
var shiftdeg = 0.0

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate
{
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var newarr: UIImageView!
    let locationManager = CLLocationManager()
    var myloc = CLLocation()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.locationManager.delegate = self
        if (CLLocationManager.locationServicesEnabled())
        {
            self.locationManager.requestWhenInUseAuthorization()
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
            self.locationManager.startUpdatingLocation()
        }
        // Start heading updates.
        if (CLLocationManager.headingAvailable())
        {
            self.locationManager.headingFilter = 1;
            self.locationManager.startUpdatingHeading()
        }
        self.label1.text = "Tap screen for map"
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!)
    {
        self.getdir(manager.location)
        self.getdist(manager.location)
        //self.loclabel.text = "Altitude: \(round(manager.location.altitude*3.28))"
        if(destlat != 0.0)
        {
            dolabels()
        }
    }

    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!)
    {
            println("Error" + error.localizedDescription)
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateHeading newHeading: CLHeading!)
    {
            if(destlat != 0.0 && self.locationManager.location != nil)
            {
                getdir(manager.location)
                getdist(manager.location)
                var dirfin = newHeading.trueHeading + dir1
                if (dirfin > 360.0)
                {
                    dirfin = dirfin - 360.0
                }
                if (UIDevice.currentDevice().orientation == UIDeviceOrientation.Portrait)
                {
                    shiftdeg = 0.0
                }
                else if (UIDevice.currentDevice().orientation == UIDeviceOrientation.LandscapeLeft)
                {
                    shiftdeg = 90.0
                }
                else if (UIDevice.currentDevice().orientation == UIDeviceOrientation.LandscapeRight)
                {
                    shiftdeg = -90.0
                }
                newarr.transform=CGAffineTransformMakeRotation(-(CGFloat((dirfin + shiftdeg) * (M_PI / 180.0))))
                dolabels()
            }
    }
    
    func number(x: NSInteger) -> NSInteger
    {
        return x*x
    }

    func getdist(myloc: CLLocation)
    {
        var destloc: CLLocation =  CLLocation(latitude: destlat, longitude: destlng)
        dist1 = myloc.distanceFromLocation(destloc) as Double
    }
    func getdir(myloc: CLLocation)
    {
        var lat1rad = myloc.coordinate.latitude * (M_PI/180.0)
        var lng1rad = myloc.coordinate.longitude * (M_PI/180.0)
        var lat2rad = destlat * (M_PI/180.0)
        var lng2rad = destlng * (M_PI/180.0)
        var dir0 = atan2(sin(lng1rad-lng2rad)*cos(lat2rad), cos(lat1rad)*sin(lat2rad)-sin(lat1rad)*cos(lat2rad)*cos(lng1rad-lng2rad))*(180.0/M_PI)
        if (dir0 < 0.0)
        {
            dir0 = dir0 + 360.0
        }
        dir1 = dir0
    }
    
    func dolabels()
    {
        if (dist1 < 100)
        {
            self.label1.text = "\(round(dist1*0.328084)*10) feet"
        }
        else if (dist1 < 1000)
        {
            self.label1.text = "\(round((dist1*3.28084)/0.3)/10) yards"
        }
        else
        {
            self.label1.text = "\(round((dist1*3.28084)/528.0)/10) miles"
        }
    }
}


class ViewControllerMap: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate
{
    @IBOutlet weak var mymap: MKMapView!
    let locationManager = CLLocationManager()
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if(destlat == 0.0)
        {
            let region = MKCoordinateRegionMakeWithDistance(self.locationManager.location.coordinate, 2000, 2000)
            self.mymap.setRegion(region, animated: true)
        }
        else
        {
            var temploc: CLLocation =  CLLocation(latitude: destlat, longitude: destlng)
            let region = MKCoordinateRegionMakeWithDistance(temploc.coordinate, 2000, 2000)
            self.mymap.setRegion(region, animated: true)
            var tempcenter: CLLocationCoordinate2D =  CLLocationCoordinate2D(latitude: destlat, longitude: destlng)
            self.mymap.setCenterCoordinate(tempcenter, animated: false)
        }
    }
    
    @IBAction func centertocurrent(sender: AnyObject) {
        let region = MKCoordinateRegionMakeWithDistance(self.locationManager.location.coordinate, 2000, 2000)
        self.mymap.setRegion(region, animated: true)
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func HomeButtonPressed(sender: AnyObject)
    {
        destlat = mymap.centerCoordinate.latitude
        destlng = mymap.centerCoordinate.longitude
    }
}