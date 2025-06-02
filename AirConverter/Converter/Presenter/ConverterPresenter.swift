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
    
    var fromCurrency: CurrencyModel = CurrencyModel(name: "CNY", flag: "🇨🇳", amount: 0)
    var toCurrency: CurrencyModel = CurrencyModel(name: "RUB", flag: "🇷🇺", amount: 0)
    
    var rates: [String : Double]?
    var inverseRates: [String : Double]?
    
    // MARK: - viewDidLoad

    func viewDidLoad() {
        loadExchangeRates()
    }
    
    // MARK: - viewDidLoad
    
    @objc func topTextFieldChanged(_ sender: UITextField, rowNumber: Int) {
        if sender.text != ""  {
            fromCurrency.amount = Double(sender.text!)!
        }
        calculate(standart: true)
    }
    
    @objc func bottomTextFieldChanged(_ sender: UITextField, rowNumber: Int) {
        if sender.text != ""  {
            toCurrency.amount = Double(sender.text!)!
        }
        calculate(standart: false)
    }
    
    @objc func сurrencyButtonTapped() {
        view?.presentSheet(currentCurrencies: [fromCurrency.name, toCurrency.name])
    }
    
    func currenciesChanged(fromCurrency: String, toCurrency: String) {
        self.fromCurrency = currencies.first(where: {$0.name == fromCurrency})!
        self.toCurrency = currencies.first(where: {$0.name == toCurrency})!
        view?.tableView.reloadData()
    }
    
    func loadExchangeRates() {
        currencyWebService.fetchRates(for: fromCurrency.name.lowercased()) { resultRates in
            self.rates = resultRates
        }
        currencyWebService.fetchRates(for: toCurrency.name.lowercased()) { resultRates in
            self.inverseRates = resultRates
        }
    }
    
    func calculate(standart: Bool) {
        let indexPath: IndexPath
        if standart {
            guard let rate = rates?[toCurrency.name.lowercased()] else { return }
            let result = Double(fromCurrency.amount * rate).rounded()
            toCurrency.amount = result
            
            indexPath = IndexPath(row: 1, section: 0)
        } else {
            guard let rate = inverseRates?[fromCurrency.name.lowercased()] else { return }
            let result = Double(toCurrency.amount * rate).rounded()
            fromCurrency.amount = result
            
            indexPath = IndexPath(row: 0, section: 0)
        }
        
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
        cell.currencyNameButton.addTarget(self, action: #selector(сurrencyButtonTapped), for: .touchUpInside)
        
        return cell
    }
    
    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
}
