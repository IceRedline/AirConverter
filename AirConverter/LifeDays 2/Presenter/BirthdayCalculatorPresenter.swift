//
//  DaysCalculatorPresenter.swift
//  AirConverter
//
//  Created by Артем Табенский on 11.05.2025.
//

import UIKit

class BirthdayCalculatorPresenter: BirthdayCalculatorPresenterProtocol {
    
    var view: BirthdayCalculatorViewControllerProtocol?
    
    private var birthdayDate = Date.now
    private var lastDateWasIncorrect: Bool = false
    
    func updateBirthdayDate(with date: Date) {
        birthdayDate = date
        if date <= Date.now {
            if lastDateWasIncorrect {
                view?.resetUIAfterIncorrectDate()
            }
        } else {
            lastDateWasIncorrect = true
            view?.showIncorrectDateLabel()
        }
    }
    
    func calculateResult() {
        let range = birthdayDate..<Date.now
        let numberOfDays = range.formatted(.components(style: .wide, fields: [.day]).locale(Locale(identifier: "ru")))
        let resultText = "Ты наслаждаешься жизнью уже \(numberOfDays)!"
        
        view?.updateResultLabel(with: resultText)
    }
}
