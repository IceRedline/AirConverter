//
//  WordsCounterViewControllerProtocol.swift
//  AirConverter
//
//  Created by Артем Табенский on 22.05.2025.
//

import UIKit

protocol WordsCounterViewControllerProtocol {

    var presenter: WordsCounterPresenterProtocol? { get set }
    var textView: UITextView { get }
    
    func updateLabels(numbersArray: [Int])
}
