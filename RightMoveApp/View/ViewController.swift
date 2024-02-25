//
//  ViewController.swift
//  RightMoveApp
//
//  Created by Sandhya on 23/02/2024.
//

import UIKit

class ViewController: UIViewController {
    
    private let viewModel = PropertyViewModel(networkManager: NetworkManager())
    
    @IBOutlet weak var questionLabel: UILabel!    
    @IBOutlet weak var answerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Task {
            await viewModel.getDataFromAPI(urlString:APIEndpoint.baseUrl)
            updateUI()
        }
        
        print("I am here")
    }
    
    func updateUI() {
        let averagePrice = self.viewModel.calculateAveragePropertyPrice()
        self.answerLabel.text = "Average property price: £ " + averagePrice
        print("**********************")
        print(averagePrice)
    }
        
}

