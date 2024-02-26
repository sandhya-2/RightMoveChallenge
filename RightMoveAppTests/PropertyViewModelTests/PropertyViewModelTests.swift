//
//  PropertyViewModelTests.swift
//  RightMoveAppTests
//
//  Created by Sandhya on 25/02/2024.
//

import XCTest
@testable import RightMoveApp

final class PropertyViewModelTests: XCTestCase {

    var viewModel: PropertyViewModel!
    var mockNetworkManager: MockNetworkManager!
    
    override func setUp() {
        super.setUp()
        mockNetworkManager = MockNetworkManager()
        viewModel = PropertyViewModel(networkManager: mockNetworkManager)
    }

    override func tearDownWithError() throws {
        viewModel = nil
        mockNetworkManager = nil
        super.tearDown()

    }

    func testGetDataFromAPI_WithValidURL_CallsNetworkManagerGet() async {
        // Given
        let expectation = XCTestExpectation(description: "Fetching Property list")
        
        // When
        
        await viewModel.getDataFromAPI(urlString: "PropertySample")
        
        // Then
        XCTAssertTrue(viewModel.propertyList.count > 0)
        let propertyData = viewModel.propertyList.first
        XCTAssertEqual(1, propertyData?.id)
        XCTAssertEqual("Richard Lane", propertyData?.address)
        XCTAssertEqual( 1000000, propertyData?.price)
        XCTAssertNil(viewModel.customError)
        
        expectation.fulfill()
        
        // Then
        
    }
    

}
