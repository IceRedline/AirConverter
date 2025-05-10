//
//  ConverterModel.swift
//  AirConverter
//
//  Created by Артем Табенский on 08.05.2025.
//

import Foundation

struct ConverterModel {
    
    private(set) var currencyRates = CurrencyRates()
 
    mutating func setCurrencyRates(_ currencyRates: CurrencyRates) {
        self.currencyRates = currencyRates
    }
    
    func convert(_ source: CurrencyAmount, to target: Currency) -> Double {
        guard
            let sourceRate = currencyRates[source.currency],
            let targetRate = currencyRates[target]
        else { return 0 }
        
        if targetRate.isZero {
            return 0
        } else {
            return source.amount * sourceRate / targetRate
        }
    }
}
