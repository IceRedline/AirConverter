import UIKit
import DGCharts

final class ConverterPresenter: NSObject, ConverterPresenterProtocol {
    
    var view: ConverterViewControllerProtocol?
    let currencyWebService = CurrencyWebService.shared
    
    let dateFormatter = DateFormatter()
    
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
        dateFormatter.dateFormat = "yyyy-MM-dd"
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
        view?.updateLabel(fromCurrency: fromCurrency, toCurrency: toCurrency)
    }
    
    func loadExchangeRates() {
        currencyWebService.fetchRates(for: fromCurrency.name.lowercased()) { resultRates in
            self.rates = resultRates
        }
        currencyWebService.fetchRates(for: toCurrency.name.lowercased()) { resultRates in
            self.inverseRates = resultRates
        }
        
        updateChartData()
        view?.updateLabel(fromCurrency: fromCurrency.name, toCurrency: toCurrency.name)
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
    
    
    func updateChartData() {
        let today = Date()
        let datesArray: [String] = (0...10).compactMap {
            guard let date = Calendar.current.date(byAdding: .day, value: -$0, to: today) else { return nil }
            return dateFormatter.string(from: date)
        }
        var ratesStatisticsArray = Array(repeating: 0.0, count: datesArray.count)
        let dispatchGroup = DispatchGroup()
        
        for (index, dateElement) in datesArray.enumerated() {
            dispatchGroup.enter()
            currencyWebService.fetchRates(for: fromCurrency.name.lowercased(), on: dateElement) { resultRates in
                if let rate = resultRates[self.toCurrency.name.lowercased()] {
                    ratesStatisticsArray[index] = rate
                }
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            print("Все курсы загружены в правильном порядке:")
            for (date, rate) in zip(datesArray, ratesStatisticsArray) {
                print("\(date): \(rate)")
            }
            
            let lineChartEntries = [
                ChartDataEntry(x: 10, y: Double(ratesStatisticsArray[0])),
                ChartDataEntry(x: 9, y: Double(ratesStatisticsArray[1])),
                ChartDataEntry(x: 8, y: Double(ratesStatisticsArray[2])),
                ChartDataEntry(x: 7, y: Double(ratesStatisticsArray[3])),
                ChartDataEntry(x: 6, y: Double(ratesStatisticsArray[4])),
                ChartDataEntry(x: 5, y: Double(ratesStatisticsArray[5])),
                ChartDataEntry(x: 4, y: Double(ratesStatisticsArray[6])),
                ChartDataEntry(x: 3, y: Double(ratesStatisticsArray[7])),
                ChartDataEntry(x: 2, y: Double(ratesStatisticsArray[8])),
                ChartDataEntry(x: 1, y: Double(ratesStatisticsArray[9])),
            ]
            let dataSet = LineChartDataSet(entries: lineChartEntries)
            dataSet.valueFormatter = TruncatingValueFormatter()
            self.view?.updateChart(dataSet: dataSet)
        }
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
