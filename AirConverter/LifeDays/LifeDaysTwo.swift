//
//  ViewController.swift
//  LifeDays
//
//  Created by Артем Табенский on 04.03.2024.
//

import UIKit

class LifeDaysTwo: UIViewController {
    
    let lifeDaysLabel: UILabel = {
        let label = UILabel()
        label.text = "Радуйся каждому дню!"
        label.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let birthdayLabel: UILabel = {
        let label = UILabel()
        label.text = "Выбери свой день рождения:"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var datePickerWheels: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.addTarget(self, action: #selector(datePickerWheelChanged), for: .valueChanged)
        return datePicker
    }()
    
    lazy var resultButton: UIButton = {
        let button = UIButton()
        button.setTitle("Посчитать", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(resultButtonTapped), for: .touchUpInside)
        return button
    }()
    
    var resultLabel: UILabel = {
        let label = UILabel()
        label.text = "Ты наслаждаешься жизнью уже ... дней!"
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 0
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var numberOfDays = ""
    private var firstdate = Date.now
    private var seconddate = Date.now
    private var difference = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(lifeDaysLabel)
        view.addSubview(birthdayLabel)
        view.addSubview(datePickerWheels)
        view.addSubview(resultButton)
        view.addSubview(resultLabel)
        
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
        if sender.date <= Date.now {
            if resultLabel.text == "Ты что, в будущем живешь?" {
                resultLabel.text = "Ты наслаждаешься жизнью уже ... дней!"
                return
            }
            let range = sender.date..<Date.now
            numberOfDays = range.formatted(.components(style: .wide, fields: [.day]).locale(Locale(identifier: "ru")))
        }
        else {
            resultLabel.text = "Ты что, в будущем живешь?"
        }
    }
    
    @IBAction private func resultButtonTapped() {
        resultLabel.text = "Ты наслаждаешься жизнью уже \(numberOfDays)!"
    }
    
    
}

#Preview {
    let tabBar = MainTabBarController()
    tabBar.selectedIndex = 1
    return tabBar
}
