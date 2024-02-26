//
//  NetworkManager.swift
//  RightMoveApp
//
//  Created by Sandhya on 23/02/2024.
//

import Foundation

protocol Networkable {
    func get(url: URL) async throws -> Data
}


final class NetworkManager: Networkable {
     
    let urlSession: Networking
    init(urlSession: Networking = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func get(url: URL) async throws -> Data {
        do {
            let (data,_) = try await urlSession.data(from: url)
            return data
        } catch let error {
            print(error.localizedDescription)
            throw error
        }
    }

    
}
