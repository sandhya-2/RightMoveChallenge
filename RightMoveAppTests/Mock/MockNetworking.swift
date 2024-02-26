//
//  MockNetworking.swift
//  RightMoveAppTests
//
//  Created by Sandhya on 25/02/2024.
//

import Foundation
@testable import RightMoveApp

class MockNetworking: Networking {
    
    var mockData: Data!
    var mockResponse: URLResponse!
    var error: Error?
    
    func data(from url: URL, delegate: URLSessionTaskDelegate?) async throws -> (Data, URLResponse) {
        if error != nil {
            throw error!
        }
        return (mockData, mockResponse)
       
    }
}

