//
//  FirstViewController.swift
//  LifeDays
//
//  Created by Артем Табенский on 06.03.2024.
//

import UIKit

class DaysCalculatorViewController: UIViewController, DaysCalculatorViewControllerProtocol {
    
    var presenter: DaysCalculatorPresenterProtocol?
    
    let lifeDaysLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("howManyDays", comment: "")
        label.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let firstDateLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("firstDate", comment: "")
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var firstDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(firstDatePickerChanged), for: .valueChanged)
        return datePicker
    }()
    
    let secondDateLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("secondDate", comment: "")
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var secondDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(secondDatePickerChanged), for: .valueChanged)
        return datePicker
    }()
    
    lazy var resultButton: UIButton = {
        let button = UIButton()
        button.setTitle(NSLocalizedString("count", comment: ""), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        button.backgroundColor = .systemCyan
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(resultButtonTapped), for: .touchUpInside)
        return button
    }()
    
    var resultLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("...days", comment: "")
        label.font = UIFont.systemFont(ofSize: 46, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure(DaysCalculatorPresenter())
        setupUI()
    }
    
    func configure(_ presenter: DaysCalculatorPresenterProtocol) {
        self.presenter = presenter
        self.presenter?.view = self
    }
    
    private func setupUI() {
        [lifeDaysLabel, firstDateLabel, firstDatePicker, secondDateLabel, secondDatePicker, resultButton, resultLabel].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(view)
        }
        
        NSLayoutConstraint.activate([
            lifeDaysLabel.widthAnchor.constraint(equalToConstant: 350),
            lifeDaysLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lifeDaysLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            firstDateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            firstDateLabel.topAnchor.constraint(equalTo: lifeDaysLabel.bottomAnchor, constant: 40),
            firstDatePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            firstDatePicker.topAnchor.constraint(equalTo: firstDateLabel.bottomAnchor, constant: 20),
            secondDateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            secondDateLabel.topAnchor.constraint(equalTo: firstDatePicker.bottomAnchor, constant: 40),
            secondDatePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            secondDatePicker.topAnchor.constraint(equalTo: secondDateLabel.bottomAnchor, constant: 20),
            resultButton.widthAnchor.constraint(equalToConstant: 150),
            resultButton.heightAnchor.constraint(equalToConstant: 45),
            resultButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resultButton.topAnchor.constraint(equalTo: secondDatePicker.bottomAnchor, constant: 60),
            resultLabel.widthAnchor.constraint(equalToConstant: 300),
            resultLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resultLabel.topAnchor.constraint(equalTo: resultButton.bottomAnchor, constant: 30)
        ])
    }
    
    @objc private func firstDatePickerChanged(_ sender: UIDatePicker) {
        presenter?.updateFirstDate(with: sender.date)
    }
    
    @objc private func secondDatePickerChanged(_ sender: UIDatePicker) {
        presenter?.updateSecondDate(with: sender.date)
    }
    
    func updateResultLabel(with string: String) {
        resultLabel.text = string
    }
    
    @objc private func resultButtonTapped() {
        presenter?.calculateResult()
    }
}

#Preview {
    let tabBar = MainTabBarController()
    tabBar.selectedIndex = 1
    return tabBar
}
