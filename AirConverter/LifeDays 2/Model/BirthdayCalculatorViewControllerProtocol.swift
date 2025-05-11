//
//  DaysCalculatorPresenterProtocol.swift
//  AirConverter
//
//  Created by Артем Табенский on 11.05.2025.
//

import Foundation

protocol BirthdayCalculatorViewControllerProtocol {
    var presenter: BirthdayCalculatorPresenterProtocol? { get set }
    
    func updateResultLabel(with string: String)
    func showIncorrectDateLabel()
    func resetUIAfterIncorrectDate()
}
