//
//  WordsCounterViewControllerProtocol.swift
//  AirConverter
//
//  Created by Артем Табенский on 22.05.2025.
//

import Foundation

protocol WordsCounterViewControllerProtocol {

    var presenter: WordsCounterPresenterProtocol? { get set }
    
    func updateLabels(numbersArray: [Int])
}
