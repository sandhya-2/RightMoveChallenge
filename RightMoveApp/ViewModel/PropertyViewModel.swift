//
//  PropertyViewModel.swift
//  RightMoveApp
//
//  Created by Sandhya on 23/02/2024.
//

import Foundation

class PropertyViewModel {
    
    var networkManager = NetworkManager()
    var propertyList: [Property] = []
    private var customError: NetworkError?
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func getDataFromAPI(urlString: String) async {
        guard let url = URL(string: urlString) else {
            customError = NetworkError.invalidURL
            return
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let propertyData = try await networkManager.get(url: url)
            let parsedData = try decoder.decode(PropertyResponse.self, from: propertyData)
            
            self.propertyList = parsedData.properties
            
            print("Propties ******")
            print(self.propertyList)
            
        } catch let error {
            print(error.localizedDescription)
            if error as? NetworkError == NetworkError.dataNotFound {
                customError = NetworkError.dataNotFound
            } else {
                customError = NetworkError.parsingError
            }
        }
        
    }
    
    func calculateAveragePropertyPrice() -> String {
        
        if propertyList.isEmpty {
            return "No data available"
        }
        
        let totalPropertyPrice = propertyList.reduce(0) { $0 + $1.price }
        let averagePropertyPrice = Double(totalPropertyPrice) / Double(propertyList.count)
        if averagePropertyPrice.isNaN {
            return "Invalid data"
        }
        print("I am here in calculate function")
        let averagePriceString = String(format: "%.2f", averagePropertyPrice)
        return averagePriceString
    }
    
    
    
}
