//
//  AssemblTests.swift
//  AssemblTests
//
//  Created by Kiara Wahnschafft on 5/3/17.
//  Copyright © 2017 KSK. All rights reserved.
//

import XCTest

@testable import Assembl

class AssemblTests: XCTestCase {
    
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
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    //MARK: Assembl Class Tests
    
    // Confirm that the Event initializer returns an Event object when passed valid parameters.
    func testEventInitializationSucceeds() {
        let eventOne = Event.init(name: "Women's March", info: "cool protest", photo: nil)
        XCTAssertNotNil(eventOne)
    
        let eventTwo = Event.init(name: "Men's Parade", info: "bad protest", photo: nil)
        XCTAssertNotNil(eventTwo)
    }
    
    // Confirm that the Event initialier returns nil when passed an empty name or description.
    func testEventInitializationFails() {
        // Empty name
        let emptyNameEvent = Event.init(name: "", info: "empty name", photo: nil)
        XCTAssertNil(emptyNameEvent)
        
        // Empty description
        let emptyDescriptionEvent = Event.init(name: "empty description", info: "", photo: nil)
        XCTAssertNil(emptyDescriptionEvent)
    }
}
