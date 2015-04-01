//
//  GoThatWayTests.swift
//  GoThatWayTests
//
//  Created by Pair Programming on 2/23/15.
//  Copyright (c) 2015 JSAHN. All rights reserved.
//

import UIKit
import XCTest

class GoThatWayTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        XCTAssert(true, "Pass")
    }
    
//    func DISABLE_testHeadingLabel() {
//        // This is an example of a functional test case.
//        //let v = ViewController()
//        var storyboard = UIStoryboard()
//        var controller = storyboard.instantiateViewControllerWithIdentifier("ViewController") as UINavigationController
//        let v = ViewController()
//        controller.viewDidLoad()
//        XCTAssert(v.DirectionLabel.text == "Heading: \(round(v.locationManager.heading.trueHeading))", "Pass")
//    }
    
    func testInterfaceObjects() {
        // This is an example of a functional test case.
        let v = ViewController()
        
        XCTAssertNotNil(v, "Pass")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
