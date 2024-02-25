//
//  PropertyResponse.swift
//  RightMoveApp
//
//  Created by Sandhya on 23/02/2024.
//

import Foundation

// MARK: - PropertyResponse
struct PropertyResponse: Codable {
    var properties: [Property]
}

// MARK: - Property
struct Property: Codable {
    var id, price, bedrooms, bathrooms: Int
    var number, address, region, postcode: String
    var propertyType: String
}

/* API response*/
/*
 {
   "properties" : [
     {
       "id": 1,
       "price": 1000000,
       "bedrooms": 7,
       "bathrooms":2,
       "number": "12",
       "address": "Richard Lane",
       "region": "London",
       "postcode": "W1F 3FT",
       "propertyType": "DETACHED"
     },
     {
       "id": 2,
       "price": 100000,
       "bedrooms": 2,
       "bathrooms":1,
       "number": "22",
       "address": "Brick Road",
       "region": "Sheffield",
       "postcode": "SH1 1AW",
       "propertyType": "TERRACED"
     },
     {
       "id": 3,
       "price": 225000,
       "bedrooms": 5,
       "bathrooms":0,
       "number": "40",
       "address": "Yellow Lane",
       "region": "Manchester",
       "postcode": "MA12 3ZY",
       "propertyType": "DETACHED"
     },
     {
       "id": 4,
       "price": 150000,
       "bedrooms": 1,
       "bathrooms":1,
       "number": "3B",
       "address": "Red Admiral Court",
       "region": "Essex",
       "postcode": "RM2 6ET",
       "propertyType": "FLAT"
     }
 }
 
 */
