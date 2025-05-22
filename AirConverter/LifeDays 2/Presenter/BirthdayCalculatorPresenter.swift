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
        let numberOfDays = abs(Calendar.current.dateComponents([.day], from: Date(), to: birthdayDate).day ?? 0000)
        let localizedNumberOfDays = String.localizedStringWithFormat(NSLocalizedString("numberOfDays", comment: ""), numberOfDays)
        
        let resultText = NSLocalizedString("defaultBirthdayText", comment: "") + String(localizedNumberOfDays) + "!"
        
        view?.updateResultLabel(with: resultText)
    }
}
