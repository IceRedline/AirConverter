//
//  WordsCounterPresenterProtocol.swift
//  AirConverter
//
//  Created by Артем Табенский on 22.05.2025.
//

import Foundation

protocol WordsCounterPresenterProtocol {
    
    var viewController: WordsCounterViewControllerProtocol? { get set }
    
    func viewDidLoad()
    func count(text: String)
}
