//
//  SwiftUICustomToggleUITestsLaunchTests.swift
//  SwiftUICustomToggleUITests
//
//  Created by Gab on 2024/04/26.
//

import XCTest

final class SwiftUICustomToggleUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launchArguments = ["isRunningUITests"]
        app.launch()
        
        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

//        let attachment = XCTAttachment(screenshot: app.screenshot())
//        attachment.name = "Launch Screen"
//        attachment.lifetime = .keepAlways
//        add(attachment)
    }
    
    func testToggleUI() {
        let app = XCUIApplication()
        app.launchArguments = ["UITest_MYToggle"]
        app.launch()
        
//        let button = app.buttons["MyButton"]
        let toggle = app.switches["MyToggle"]
        
//        XCTAssertNotNil(button)
        XCTAssertNotNil(toggle)
        
//        XCTAssertTrue(button.label == "OFF", "button label : \(button.label)")
        XCTAssertTrue(toggle.label == "OFF", "toggle label : \(toggle.label)")
        
//        button.tap()
        toggle.switches.firstMatch.tap()
        
//        XCTAssertTrue(button.label == "ON", "button label : \(button.label)")
        XCTAssertTrue(toggle.label == "ON", "toggle label : \(toggle.label)")
    }
}
