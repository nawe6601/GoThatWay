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
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        
        
        // Do any additional setup after loading the view, typically from a nib. 
    /*
        let motionManager: CMMotionManager = CMMotionManager()
    if (motionManager.deviceMotionAvailable) {
        motionManager.showsDeviceMovementDisplay = true
        motionManager.magnetometerUpdateInterval = updateInterval
        motionManager.startDeviceMotionUpdatesUsingReferenceFrame(CMAttitudeReferenceFrameXArbitraryZVertical, toQueue: queue, withHandler: {
    (deviceMotion: CMDeviceMotion!, error: NSError!) -> Void in
    // If no device-motion data is available, the value of this property is nil.
    if let motion = deviceMotion {
    println(motion)
    var accuracy = motion.magneticField.accuracy
    var x = motion.magneticField.field.x
    var y = motion.magneticField.field.y
    var z = motion.magneticField.field.z
    println("accuracy: \(accuracy.value), x: \(x), y: \(y), z: \(z)")
    }
    else {
    println("Device motion is nil.")
    }
    })
    }*/
        
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
                self.displayLocationInfo(pm)
            }else{
                println("Error with data")
            }
            
        })
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

    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var slider1: UISlider!
    @IBOutlet weak var arr1: UIImageView!
    @IBAction func slid(sender: AnyObject) {
        label1.text = "\(round(slider1.value*20)) ft"
        arr1.transform = CGAffineTransformMakeRotation(CGFloat(slider1.value))
        arr1.layer.shouldRasterize = true
    }
    
    
   

}

