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
    
    func testAFunction() {
        // Test a simple function
        let v = ViewController()
        XCTAssertEqual(9, v.number(3), "Pass")
    }
    
    func testViewControllerNotNil() {
        // This is an example of a functional test case.
        let v = ViewController()
        XCTAssertNotNil(v, "Pass")
    }
    
    func testViewDidLoad() {
        // Test if viewcontroller loads
        let v = ViewController()
        v.loadView()
        XCTAssert(v.isViewLoaded(), "Pass")
    }
    
    func testViewAutorotate() {
        // Test if viewcontroller will autorotate
        let v = ViewController()
        XCTAssert(v.shouldAutorotate()==true, "Pass")
    }
    
    func testViewAutorotateMap() {
        // Test if viewcontroller will autorotate
        let v = ViewControllerMap()
        XCTAssert(v.shouldAutorotate()==true, "Pass")
    }
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
