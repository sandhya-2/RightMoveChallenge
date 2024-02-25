//
//  NetworkError.swift
//  RightMoveApp
//
//  Created by Sandhya on 23/02/2024.
//

import Foundation

import Foundation

enum NetworkError: Error{
    case invalidURL
    case parsingError
    case dataNotFound
}

extension NetworkError:LocalizedError{
    var errorDescription :String?{
        switch self{
        case .invalidURL:
            return NSLocalizedString("Invalid URL", comment: "invalidURL")
        case .parsingError:
            return NSLocalizedString("Parsing Error", comment: "parsingError")
        case .dataNotFound:
            return NSLocalizedString("DataNot Found", comment: "dataNotFound")
        }
    }
}
