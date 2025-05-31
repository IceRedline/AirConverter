//
//  ConverterViewModel.swift
//  AirConverter
//
//  Created by Артем Табенский on 08.05.2025.
//

import UIKit

final class ConverterPresenter: NSObject, ConverterPresenterProtocol {
    
    let currencies: [CurrencyModel] = [
        CurrencyModel(name: "USD", flag: "🇺🇸"),
        CurrencyModel(name: "RUB", flag: "🇷🇺"),
        CurrencyModel(name: "EUR", flag: "🇪🇺"),
        CurrencyModel(name: "CNY", flag: "🇨🇳"),
    ]
    
    var currentCurrencies: [CurrencyModel] = [CurrencyModel(name: "CNY", flag: "🇨🇳"), CurrencyModel(name: "RUB", flag: "🇷🇺")]
    
    var view: ConverterViewControllerProtocol?
    
    @objc func amountTextFieldChanged() {
        print("Изменено значение textField")
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ConverterTableViewCell", for: indexPath) as? ConverterTableViewCell else {
            fatalError("Не удалось привести ячейку к ConverterTableViewCell")
        }
        cell.configure(currency: currentCurrencies[indexPath.row], amount: 0)
        
        cell.amountTextField.addTarget(self, action: #selector(amountTextFieldChanged), for: .editingChanged)
        return cell
    }
    
    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
