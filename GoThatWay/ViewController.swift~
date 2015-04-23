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
import Foundation

var dist1 = 0.0
var dir1 = 0.0
var showalert = true
var current_destination = CLLocationCoordinate2DMake(0.0, 0.0)
var shiftdeg = 0.0
var dorun = false

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    @IBOutlet weak var xbutton: UIButton!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var newarr: UIImageView!
    let locationManager = CLLocationManager()
    var myloc = CLLocation()
    
    override func viewDidLoad() {
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
        
        if(!dorun)
        {
            turnoff()
        }
        else
        {
            turnon()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        if(dorun)
        {
            self.getdir(manager.location)
            self.getdist(manager.location)
            dolabels()
        }
    }

    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
            println("Error" + error.localizedDescription)
    }
    
    
    func locationManager(manager: CLLocationManager!, didUpdateHeading newHeading: CLHeading!) {
        if(dorun && self.locationManager.location != nil)
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
    func number(x: NSInteger) -> NSInteger {
        return x*x
    }

    /**
        Get distance function.
    
        :param: myloc: The user's current location.
    
        :returns: The distance to the stored location.
    */
    func getdist(myloc: CLLocation) {
        var tempdest: CLLocation =  CLLocation(latitude: current_destination.latitude, longitude: current_destination.longitude)
        dist1 = myloc.distanceFromLocation(tempdest) as Double
    }
    /**
        Get direction function.
    
        :param: myloc: A location variable.
    
        :returns: The direction to the stored location.
    */
    func getdir(myloc: CLLocation) {
        var lat1rad = myloc.coordinate.latitude * (M_PI/180.0)
        var lng1rad = myloc.coordinate.longitude * (M_PI/180.0)
        var lat2rad = current_destination.latitude * (M_PI/180.0)
        var lng2rad = current_destination.longitude * (M_PI/180.0)
        var dir0 = atan2(sin(lng1rad-lng2rad)*cos(lat2rad), cos(lat1rad)*sin(lat2rad)-sin(lat1rad)*cos(lat2rad)*cos(lng1rad-lng2rad))*(180.0/M_PI)
        if (dir0 < 0.0)
        {
            dir0 = dir0 + 360.0
        }
        dir1 = dir0
    }
     /**
        Generates labels depending on the distance to the stored location.

        :param: None.
    
        :returns: Either miles, feet, or yards depending on distance.
    */
    func dolabels() {
        var tempdist = (dist1*3.28084)/5280.0
        var tempunit = " miles"
        var tempformat = "%.0f"
        if (tempdist < 0.1)
        {
            tempdist = dist1*3.28084
            tempunit = " feet"
        }
        else if (tempdist < 0.5)
        {
            tempdist = (dist1*3.28084)/3.0
            tempunit = " yards"
        }
        else if (tempdist < 50)
        {
            tempformat = "%.1f"
        }
        self.label1.text = String(format: tempformat + tempunit, tempdist)
    }
    
    @IBAction func gotomap(sender: AnyObject) {
        self.locationManager.startUpdatingHeading()
        self.locationManager.startUpdatingLocation()
    }
    
    @IBAction func stopguidance(sender: AnyObject) {
        if(dorun){
            dorun = false
            turnoff()
        }
        else
        {
            dorun = true
            turnon()
        }
    }
     /**
        Restarts heading and location updates.

        :param: None.

	:returns: None.
    */
    func turnon() {
        self.locationManager.startUpdatingHeading()
        self.locationManager.startUpdatingLocation()
        xbutton.hidden = false
        xbutton.setTitle("stop", forState: UIControlState.Normal)
    }
      /**
        Turns off heading and location updates.

        :param: None.

	:returns: None.

    */
    func turnoff() {
        if(current_destination.latitude == 0.0)
        {
            xbutton.hidden = true
        }
        else
        {
            xbutton.setTitle("start", forState: UIControlState.Normal)
        }
        self.locationManager.stopUpdatingHeading()
        self.locationManager.stopUpdatingLocation()
        //xbutton.hidden = true
        self.label1.text = "Tap screen for map"
        newarr.transform=CGAffineTransformMakeRotation(0)
    }
}

class ViewControllerMap: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    @IBOutlet weak var mymap: MKMapView!
    let locationManager = CLLocationManager()
    let mapManager = MKMapView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if(self.locationManager.location != nil)
        {
            if(current_destination.longitude == 0.0)
            {
                self.mymap.setRegion(MKCoordinateRegionMakeWithDistance(self.locationManager.location.coordinate, 2000, 2000), animated: false)
            }
            else
            {
                self.mymap.setRegion(MKCoordinateRegionMakeWithDistance(current_destination, dist1 * 4.0, dist1 * 4.0), animated: false)
                self.mymap.setCenterCoordinate(current_destination, animated: false)
            }
        }
        
        var alertView:UIAlertView = UIAlertView()
        alertView.title = "Instructions"
        alertView.message = "Move the map so the crosshair is on your destination"
        alertView.delegate = self
        alertView.addButtonWithTitle("OK")
        alertView.addButtonWithTitle("Don't show again")
        
        if(showalert)
        {
            alertView.show()
        }
    }
    /**
	Turns off the instructions message.
    
        :param: View: The view that is calling the function.
        :param: buttonIndex: The index of the button that was pressed.

        :returns: None.
    */
    func alertView(View: UIAlertView!, clickedButtonAtIndex buttonIndex: Int) {
        if(buttonIndex == 1)
        {
            showalert = false
        }
    }
    
    @IBAction func centertocurrent(sender: AnyObject) {
        self.mymap.setCenterCoordinate(self.locationManager.location.coordinate, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func HomeButtonPressed(sender: AnyObject) {
        current_destination = mymap.centerCoordinate
        dorun = true
    }
}
