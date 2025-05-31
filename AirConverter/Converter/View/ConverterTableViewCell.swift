//
//  ConverterTableViewCell.swift
//  AirConverter
//
//  Created by Артем Табенский on 27.05.2025.
//

import UIKit

class ConverterTableViewCell: UITableViewCell {
    
    var currencyNameButton = UIButton()
    let currencyFlagLabel = UILabel()
    let amountTextField = UITextField()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        currencyNameButton.addTarget(self, action: #selector(currencyNameButtonTapped(_:)), for: .touchUpInside)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.backgroundColor = .systemGray6
        [currencyNameButton, currencyFlagLabel, amountTextField].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
            self.contentView.addSubview(view)
        }
        
        currencyFlagLabel.font = UIFont.systemFont(ofSize: 60)
        currencyFlagLabel.textAlignment = .center
        currencyNameButton.titleLabel?.font = UIFont.systemFont(ofSize: 22)
        currencyNameButton.setTitleColor(.systemBlue, for: .normal)
        amountTextField.textColor = .systemBlue
        amountTextField.textAlignment = .right
        amountTextField.font = UIFont.systemFont(ofSize: 28)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            currencyFlagLabel.widthAnchor.constraint(equalToConstant: 70),
            currencyFlagLabel.heightAnchor.constraint(equalToConstant: 50),
            currencyFlagLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            currencyFlagLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.defaultPadding),
            currencyNameButton.widthAnchor.constraint(equalToConstant: 50),
            currencyNameButton.heightAnchor.constraint(equalToConstant: 28),
            currencyNameButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.defaultPadding),
            currencyNameButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            amountTextField.widthAnchor.constraint(equalToConstant: 150),
            amountTextField.heightAnchor.constraint(equalToConstant: 35),
            amountTextField.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            amountTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.defaultPadding)
        ])
    }
    
    func configure(currency: CurrencyModel) {
        currencyNameButton.setTitle(currency.name, for: .normal)
        currencyFlagLabel.text = currency.flag
        amountTextField.text = String(currency.amount)
    }
    
    @objc func currencyNameButtonTapped(_ sender: UIButton) {
        
    }
}
