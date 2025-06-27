//
//  CurrencyWebService.swift
//  AirConverter
//
//  Created by Артем Табенский on 31.05.2025.
//

import Foundation

class CurrencyWebService {
    
    static let shared = CurrencyWebService()
    
    private init() {}
    
    let baseURL: String = "https://cdn.jsdelivr.net/npm/@fawazahmed0/currency-api@"
    
    func makeURLRequest(currencyLiteral: String, date: String) -> URLRequest? {
        let fullURLString = baseURL + "\(date)" + "/v1/currencies/" + "\(currencyLiteral).json"
        
        guard let url = URL(string: fullURLString) else {
            print("не удалось создать url с \(fullURLString)")
            return nil
        }
        
        print("Запрошен URL: \(url)")
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return request
    }
    
    
    func fetchRates(for currency: String, on date: String = "latest", completion: @escaping ([String: Double]) -> Void) {
        guard let request = makeURLRequest(currencyLiteral: currency, date: date) else { return }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }

            
            guard let data else { return }
            
            do {
                let result = try JSONDecoder().decode(CurrencyRates.self, from: data)
                print("CurrencyWebService: Курсы загружены")
                completion(result.rates)
            } catch {
                print("CurrencyWebService: Decoding error: \(error)")
            }
        }
        task.resume()
    }
}
