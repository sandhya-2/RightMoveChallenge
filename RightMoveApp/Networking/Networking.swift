//
//  Networkable.swift
//  RightMoveApp
//
//  Created by Sandhya on 23/02/2024.
//

import Foundation

protocol Networking {
    func data(from url: URL,delegate: URLSessionTaskDelegate?) async throws -> (Data, URLResponse)
}

extension Networking {
    func data(from url: URL) async throws -> (Data, URLResponse) {
           try await data(from: url, delegate: nil)
       }
}
extension URLSession: Networking {}
