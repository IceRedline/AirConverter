//
//  DaysCalculatorPresenter.swift
//  AirConverter
//
//  Created by Артем Табенский on 11.05.2025.
//

import Foundation

class DaysCalculatorPresenter: DaysCalculatorPresenterProtocol {
    
    var view: DaysCalculatorViewControllerProtocol?
    
    private var firstDate = Date.now
    private var secondDate = Date.now
    private var difference = 0
    
    func updateFirstDate(with date: Date) {
        firstDate = date
    }
    
    func updateSecondDate(with date: Date) {
        secondDate = date
    }
    
    func calculateResult() {
        difference = abs(Calendar.current.dateComponents([.day], from: firstDate, to: secondDate).day ?? 0000) 
        let resultText = String.localizedStringWithFormat(NSLocalizedString("numberOfDays", comment: ""), difference)
        
        view?.updateResultLabel(with: resultText)
    }
}
