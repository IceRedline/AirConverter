//
//  DaysCalculatorPresenterProtocol.swift
//  AirConverter
//
//  Created by Артем Табенский on 11.05.2025.
//

import Foundation

protocol DaysCalculatorViewControllerProtocol {
    var presenter: DaysCalculatorPresenterProtocol? { get set }
    
    func updateResultLabel(with string: String)
}
