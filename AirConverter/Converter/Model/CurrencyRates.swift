//
//  CurrencyRates.swift
//  AirConverter
//
//  Created by Артем Табенский on 31.05.2025.
//

import Foundation

struct CurrencyRates: Codable {
    let date: String
    let baseCurrency: String
    let rates: [String: Double]
    
    private struct DynamicCodingKeys: CodingKey {
        var stringValue: String
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        
        var intValue: Int?
        init?(intValue: Int) { nil }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DynamicCodingKeys.self)
        
        // Декодируем дату
        guard let dateKey = DynamicCodingKeys(stringValue: "date") else {
            throw DecodingError.dataCorrupted(.init(codingPath: [], debugDescription: "Date key not found"))
        }
        date = try container.decode(String.self, forKey: dateKey)
        
        // Находим ключ базовой валюты (например, "usd", "eur")
        guard let baseCurrencyKey = container.allKeys.first(where: { $0.stringValue != "date" }) else {
            throw DecodingError.dataCorrupted(.init(codingPath: [], debugDescription: "Base currency key not found"))
        }
        baseCurrency = baseCurrencyKey.stringValue
        
        // Декодируем вложенный словарь курсов
        let ratesContainer = try container.nestedContainer(keyedBy: DynamicCodingKeys.self, forKey: baseCurrencyKey)
        var ratesDict = [String: Double]()
        for key in ratesContainer.allKeys {
            let rate = try ratesContainer.decode(Double.self, forKey: key)
            ratesDict[key.stringValue] = rate
        }
        rates = ratesDict
    }
}
