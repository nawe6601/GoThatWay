//
//  ViewController.swift
//  GoThatWay
//
//  Created by Pair Programming on 2/23/15.
//  Copyright (c) 2015 JSAHN. All rights reserved.
//



import UIKit
import CoreMotion

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
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

    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var slider1: UISlider!
    @IBOutlet weak var arr1: UIImageView!
    @IBAction func slid(sender: AnyObject) {
        label1.text = "\(round(slider1.value*20)) ft"
        arr1.transform = CGAffineTransformMakeRotation(CGFloat(slider1.value))
        arr1.layer.shouldRasterize = true
    }
    
    
   

}

