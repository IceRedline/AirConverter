//
//  ViewController.swift
//  LifeDays
//
//  Created by Артем Табенский on 04.03.2024.
//

import UIKit

class BirthdayCalculator: UIViewController, BirthdayCalculatorViewControllerProtocol {
    
    var presenter: BirthdayCalculatorPresenterProtocol?
    
    let lifeDaysLabel: UILabel = {
        let label = UILabel()
        label.text = "Радуйся каждому дню!"
        label.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    let birthdayLabel: UILabel = {
        let label = UILabel()
        label.text = "Выбери свой день рождения:"
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    lazy var datePickerWheels: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.addTarget(self, action: #selector(datePickerWheelChanged), for: .valueChanged)
        return datePicker
    }()
    
    lazy var resultButton: UIButton = {
        let button = UIButton()
        button.setTitle("Посчитать", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(resultButtonTapped), for: .touchUpInside)
        return button
    }()
    
    var resultLabel: UILabel = {
        let label = UILabel()
        label.text = "Ты наслаждаешься жизнью уже ... дней!"
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure(BirthdayCalculatorPresenter())
        setupUI()
    }
    
    func configure(_ presenter: BirthdayCalculatorPresenterProtocol) {
        self.presenter = presenter
        self.presenter?.view = self
    }
    
    private func setupUI() {
        [lifeDaysLabel, birthdayLabel, datePickerWheels, resultButton, resultLabel].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(view)
        }
        
        NSLayoutConstraint.activate([
            lifeDaysLabel.widthAnchor.constraint(equalToConstant: 350),
            lifeDaysLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lifeDaysLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            birthdayLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            birthdayLabel.topAnchor.constraint(equalTo: lifeDaysLabel.bottomAnchor, constant: 40),
            datePickerWheels.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            datePickerWheels.topAnchor.constraint(equalTo: birthdayLabel.bottomAnchor, constant: 20),
            resultButton.widthAnchor.constraint(equalToConstant: 150),
            resultButton.heightAnchor.constraint(equalToConstant: 45),
            resultButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resultButton.topAnchor.constraint(equalTo: datePickerWheels.bottomAnchor, constant: 40),
            resultLabel.widthAnchor.constraint(equalToConstant: 300),
            resultLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resultLabel.topAnchor.constraint(equalTo: resultButton.bottomAnchor, constant: 30)
        ])
    }
    
    @objc private func datePickerWheelChanged(_ sender: UIDatePicker) {
        presenter?.updateBirthdayDate(with: sender.date)
    }
    
    @objc private func resultButtonTapped() {
        presenter?.calculateResult()
    }
    
    func updateResultLabel(with string: String) {
        resultLabel.text = string
    }
    
    func showIncorrectDateLabel() {
        resultButton.isEnabled = false
        resultButton.alpha = 0.5
        resultLabel.text = "Ты что, в будущем живешь?"
    }
    
    func resetUIAfterIncorrectDate() {
        resultButton.isEnabled = true
        resultButton.alpha = 1
        resultLabel.text = "Ты наслаждаешься жизнью уже ... дней!"
    }
}

#Preview {
    let tabBar = MainTabBarController()
    tabBar.selectedIndex = 2
    return tabBar
}
