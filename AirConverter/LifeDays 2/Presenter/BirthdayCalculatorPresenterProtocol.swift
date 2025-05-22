//
//  DaysCalculatorPresenterProtocol.swift
//  AirConverter
//
//  Created by Артем Табенский on 11.05.2025.
//

import UIKit

protocol BirthdayCalculatorPresenterProtocol {
    var view: BirthdayCalculatorViewControllerProtocol? { get set }
    
    func updateBirthdayDate(with date: Date)
    func calculateResult()
}
