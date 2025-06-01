//
//  ConverterViewPresenterProtocol.swift
//  AirConverter
//
//  Created by Артем Табенский on 27.05.2025.
//

import UIKit

protocol ConverterPresenterProtocol: UITableViewDelegate, UITableViewDataSource {
    
    var view: ConverterViewControllerProtocol? { get set }
    
    func viewDidLoad()
    func currenciesChanged(fromCurrency: String, toCurrency: String)
    func loadExchangeRates()
}
