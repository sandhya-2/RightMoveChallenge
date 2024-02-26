//
//  MockNetworkManager.swift
//  RightMoveAppTests
//
//  Created by Sandhya on 25/02/2024.
//

import Foundation
@testable import RightMoveApp

/*MockNetworkManager that behaves like NetworkManager for testing ViewModel*/
class MockNetworkManager: Networkable {
    
//    var isGetCalled = false
//    
//    func get(url: URL) async throws -> Data {
//        isGetCalled = true
//        let mockData = Data()
//        return mockData
//    }

    func get(url: URL) async throws -> Data {
        do {
            let bundle = Bundle(for: MockNetworkManager.self)
            guard let resourcePath = bundle.url(forResource: url.absoluteString, withExtension: "json") else
            {
                throw NetworkError.invalidURL            }
            let data = try Data(contentsOf: resourcePath)
           
            return data
        } catch {
            throw NetworkError.dataNotFound
        }
    }
}
