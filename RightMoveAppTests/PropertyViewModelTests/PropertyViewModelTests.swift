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
        let viewModel = PropertyViewModel(networkManager: mockNetworkManager)
        XCTAssertNotNil(viewModel)
        // Given
        let expectation = XCTestExpectation(description: "Fetching Property list")
        
        // When
        await viewModel.getDataFromAPI(urlString: "PropertySample")
        
        // Then
        XCTAssertTrue(viewModel.propertyList.count > 0)
        let propertyData = viewModel.propertyList.first
        XCTAssertEqual(1, propertyData?.id)
        /* compare expected value with the actual value */
        XCTAssertEqual("Richard Lane", propertyData?.address)
        XCTAssertEqual( 1000000, propertyData?.price)
        XCTAssertNil(viewModel.customError)
        
        expectation.fulfill()

    }
    
    /* Does not receives the data when the URL is inValid */
    func test_GetDataFromAPI_WithInValidURL() async {
        let viewModel = PropertyViewModel(networkManager: mockNetworkManager)
        XCTAssertNotNil(viewModel)
        // Given
        let expectation = XCTestExpectation(description: "Data not found is received when fetching the data")
        
        // When
        await viewModel.getDataFromAPI(urlString: "PropertySample3")
        XCTAssertTrue(viewModel.propertyList.isEmpty)
        let expectedResult = 0
        let actualResult = viewModel.propertyList.count
        XCTAssertEqual(expectedResult, actualResult)
        XCTAssertNotNil(viewModel.customError)
        XCTAssertEqual(viewModel.customError, NetworkError.dataNotFound)
        expectation.fulfill()
    }
    
    /* Does not gets any data with empty string is passed */
    func test_GetDataFromAPI_WithEmptyURL() async {
        let viewModel = PropertyViewModel(networkManager: mockNetworkManager)
        XCTAssertNotNil(viewModel)
        // Given
        let expectation = XCTestExpectation(description: "Invalid Error is received when fetching the data")
        
        // When
        await viewModel.getDataFromAPI(urlString: "")
        XCTAssertTrue(viewModel.propertyList.isEmpty)
        let expectedResult = 0
        let actualResult = viewModel.propertyList.count
        XCTAssertEqual(expectedResult, actualResult)
        XCTAssertNotNil(viewModel.customError)
        XCTAssertEqual(viewModel.customError, NetworkError.invalidURL)
        expectation.fulfill()
    }
    
    /* The URL is correct but no data is received*/
    func test_GetDataFromAPI_WithCorrectURL_But_NoData_is_received() async {
        let viewModel = PropertyViewModel(networkManager: mockNetworkManager)
        XCTAssertNotNil(viewModel)
        // Given
        let expectation = XCTestExpectation(description: "API should fail to give the data")
        // When
        await viewModel.getDataFromAPI(urlString: "PropertySampleEmpty")
        XCTAssertTrue(viewModel.propertyList.isEmpty)
        let expectedResult = 0
        let actualResult = viewModel.propertyList.count
        XCTAssertEqual(expectedResult, actualResult)
        XCTAssertNotNil(viewModel.customError)
        XCTAssertEqual(viewModel.customError, NetworkError.dataNotFound)
        expectation.fulfill()
    }
    
    /* When the propertyList is empty */
    func test_CalculateAveragePropertyPrice_WithEmptyList_ReturnsNoDataAvailable() {
        let viewModel = PropertyViewModel(networkManager: mockNetworkManager)
        XCTAssertNotNil(viewModel)
        
        // Given
        viewModel.propertyList = []
        // When
        let result = viewModel.calculateAveragePropertyPrice()
        
        //Then
        XCTAssertEqual(result, "No data available")
    }
    
    func test_CalculateAveragePropertyPrice_when_theValueis_isNan_Returns_InvalidData() {
        let viewModel = PropertyViewModel(networkManager: mockNetworkManager)
        XCTAssertNotNil(viewModel)
        
        // Given
        viewModel.propertyList = [
            Property(id: 1, price: 100000, bedrooms: 1, bathrooms: 1, number: "", address: "", region: "", postcode: "", propertyType: ""),
            Property(id: 2, price: 150000, bedrooms: 2, bathrooms: 1, number: "", address: "", region: "", postcode: "", propertyType: ""),
            Property(id: 3, price: 200000, bedrooms: 3, bathrooms: 1, number: "", address: "", region: "", postcode: "", propertyType: "")
        ]
           
           // When
           let result = viewModel.calculateAveragePropertyPrice()
           
           // Then
        XCTAssertEqual(result, "150000.00")
        // Average of (100000 + 150000 + 200000) / 3 = 150000
    }
}
