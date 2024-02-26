//
//  RightMoveAppUITests.swift
//  RightMoveAppUITests
//
//  Created by Sandhya on 23/02/2024.
//

import XCTest

final class RightMoveAppUITests: XCTestCase {

    private var app:XCUIApplication!
    
    override func setUpWithError() throws {
        
        app = XCUIApplication()
        app.launch()
        continueAfterFailure = false

    }

    override func tearDownWithError() throws {
        app = nil
    }

    func testAppNotNil() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertNotNil(app)
    }

    func test_LabelExists() {
        
        let app = XCUIApplication()
        let questionTextView = app.staticTexts["What is the average property price?"]
        let averagePriceTextView = app.staticTexts["Average property price: £ 410280.78"]
        XCTAssertTrue(questionTextView.exists)
        XCTAssertTrue(averagePriceTextView.exists)
        
    }
}
