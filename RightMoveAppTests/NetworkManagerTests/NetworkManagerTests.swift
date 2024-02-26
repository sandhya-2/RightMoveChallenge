//
//  NetworkManagerTests.swift
//  RightMoveAppTests
//
//  Created by Sandhya on 25/02/2024.
//

import XCTest
@testable import RightMoveApp

final class NetworkManagerTests: XCTestCase {

    var networkManager: NetworkManager!
    var mockNetworking: MockNetworking!
    
    override func setUp() {
        super.setUp()
        mockNetworking = MockNetworking()
        networkManager = NetworkManager(urlSession: mockNetworking)
    }

    override func tearDown() {
        super.tearDown()
        mockNetworking = nil
        networkManager = nil
    }

    /*when API is successful, get(url: URL) function will return expected data*/
    func test_GetFunction_WhenResponseIs_200() async {
        
        // GIVEN
         let data = "response".data(using: .utf8)
        mockNetworking.mockData = data
        mockNetworking.mockResponse = HTTPURLResponse(url:URL(string: "test")!, statusCode: 200, httpVersion:nil, headerFields:nil)
        
        // When
        do {
            let actualData = try await networkManager.get(url: URL(string: "testURl")!)
            // Then
            XCTAssertEqual(actualData, data)
        } catch {
            XCTFail("Unexpected error \(error)")
        }
        
    }

    /*when API fails with status code 404 */
    func test_GetFunction_WhenAPIFailsToReturnExpectedData() async {

        // Given
         let data = "response".data(using: .utf8)
        mockNetworking.mockData = data
        mockNetworking.mockResponse = HTTPURLResponse(url:URL(string: "test")!, statusCode: 404, httpVersion:nil, headerFields:nil)
        
        do {
            _ = try await networkManager.get(url: URL(string: "testURl")!)
        } catch {
            XCTAssertEqual(error as! NetworkError, NetworkError.invalidURL)
        }
    }

    /*when API fails with invalid request*/
    func test_GetFunction_WhenRequestIsInValidAndYouDontGetData() async {
        do {
            //Given
            mockNetworking.error =  NetworkError.invalidURL
            
            //When
            _ = try await networkManager.get(url: URL(string: "sgdaga@$^%$")!)
         
        } catch {
            XCTAssertEqual(error as! NetworkError, NetworkError.invalidURL)
        }
    }
    
    /*when API fails with invalid request*/
    func testGetCharactersWhenRequestIsEmptyStringAndYouDontGetData() async {
        do {
            //Given
            mockNetworking.error =  NetworkError.invalidURL
            
            //When
            _ = try await networkManager.get(url: URL(string: " ")!)
         
        } catch {
            XCTAssertEqual(error as! NetworkError, NetworkError.invalidURL)
        }
    }
    
}
