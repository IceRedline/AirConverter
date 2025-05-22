//
//  DaysCalculatorPresenterProtocol.swift
//  AirConverter
//
//  Created by Артем Табенский on 11.05.2025.
//

import Foundation

protocol DaysCalculatorPresenterProtocol {
    var view: DaysCalculatorViewControllerProtocol? { get set }
    
    func updateFirstDate(with date: Date)
    func updateSecondDate(with date: Date)
    func calculateResult()
}
