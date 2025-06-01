//
//  SheetViewController.swift
//  AirConverter
//
//  Created by Артем Табенский on 01.06.2025.
//

import UIKit

class SheetViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let currenciesNames = ["CNY", "RUB", "USD", "EUR"]
    let startCurrencies: [String]
    
    var onCurrencySelected: ((String, String) -> Void)?
    var onDismiss: (() -> Void)?

    let pickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    init(startCurrencies: [String]) {
        self.startCurrencies = startCurrencies
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        

        setupViews()
        setupConstraints()
        
        pickerView.selectRow(currenciesNames.firstIndex(of: startCurrencies[0])!, inComponent: 0, animated: false)
        pickerView.selectRow(currenciesNames.firstIndex(of: startCurrencies[1])!, inComponent: 1, animated: false)
    }
    
    func setupViews() {
        view.backgroundColor = .white
        view.addSubview(pickerView)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
            super.viewDidDisappear(animated)
            onDismiss?()
        }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            pickerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pickerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    // MARK: - UIPickerViewDataSource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int { 2 }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int { currenciesNames.count }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currenciesNames[row]
    }
    
    // MARK: - UIPickerViewDelegate
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let currencyFrom = currenciesNames[pickerView.selectedRow(inComponent: 0)]
        let currencyTo = currenciesNames[pickerView.selectedRow(inComponent: 1)]
        onCurrencySelected?(currencyFrom, currencyTo)
    }
    
}


