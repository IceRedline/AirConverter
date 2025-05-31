//
//  ConverterViewModel.swift
//  AirConverter
//
//  Created by Артем Табенский on 08.05.2025.
//

import UIKit

final class ConverterPresenter: NSObject, ConverterPresenterProtocol {
    
    var view: ConverterViewControllerProtocol?
    let currencyWebService = CurrencyWebService.shared
    
    let currencies: [CurrencyModel] = [
        CurrencyModel(name: "USD", flag: "🇺🇸", amount: 0),
        CurrencyModel(name: "RUB", flag: "🇷🇺", amount: 0),
        CurrencyModel(name: "EUR", flag: "🇪🇺", amount: 0),
        CurrencyModel(name: "CNY", flag: "🇨🇳", amount: 0),
    ]
    
    var fromCurrency: CurrencyModel = CurrencyModel(name: "CNY", flag: "🇨🇳", amount: 0) {
        didSet {
            calculate()
        }
    }
    var toCurrency: CurrencyModel = CurrencyModel(name: "RUB", flag: "🇷🇺", amount: 0) {
        didSet {
            //calculate(standart: true)
        }
    }
    
    var rates: [String : Double]?
    
    func viewDidLoad() {
        currencyWebService.fetchRates(for: fromCurrency.name.lowercased()) { resultRates in
            self.rates = resultRates
        }
    }
    
    @objc func topTextFieldChanged(_ sender: UITextField, rowNumber: Int) {
        if sender.text != nil {
            fromCurrency.amount = Double(sender.text!)!
        }
        
    }
    
    @objc func bottomTextFieldChanged(_ sender: UITextField, rowNumber: Int) {
        if sender.text != nil  {
            toCurrency.amount = Double(sender.text!)!
        }
    }
    
    func topCurrencyChanged() {
        
    }
    
    func bottomCurrencyChanged() {
        
    }
    
    func calculate() {
        guard let rate = rates?[toCurrency.name.lowercased()] else { return }
        let result = Double(fromCurrency.amount * rate).rounded()
        toCurrency.amount = result
        
        let indexPath = IndexPath(row: 1, section: 0)
        view?.tableView.reloadRows(at: [indexPath], with: .none)
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ConverterTableViewCell", for: indexPath) as? ConverterTableViewCell else {
            fatalError("ConverterPresenter - cellForRowAt: Не удалось привести ячейку к ConverterTableViewCell")
        }
        
        switch indexPath.row {
        case 0:
            cell.configure(currency: fromCurrency)
            cell.amountTextField.addTarget(self, action: #selector(topTextFieldChanged), for: .editingChanged)
        case 1:
            cell.configure(currency: toCurrency)
            cell.amountTextField.addTarget(self, action: #selector(bottomTextFieldChanged), for: .editingChanged)
        default: fatalError("ConverterPresenter - cellForRowAt: Не удалось распознать ряд")
        }
        
        return cell
    }
    
    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
