//
//  FirstViewController.swift
//  LifeDays
//
//  Created by Артем Табенский on 06.03.2024.
//

import UIKit

class LifeDaysOne: UIViewController {
    
    let lifeDaysLabel: UILabel = {
        let label = UILabel()
        label.text = "Сколько прошло дней между двумя датами"
        label.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let firstDateLabel: UILabel = {
        let label = UILabel()
        label.text = "Первая дата"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let firstDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.addTarget(self, action: #selector(firstDatePickerChanged), for: .valueChanged)
        return datePicker
    }()
    
    let secondDateLabel: UILabel = {
        let label = UILabel()
        label.text = "Вторая дата"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let secondDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.addTarget(self, action: #selector(secondDatePickerChanged), for: .valueChanged)
        return datePicker
    }()
    
    var resultButton: UIButton = {
        let button = UIButton()
        button.setTitle("Посчитать", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        button.backgroundColor = .systemCyan
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(resultButtonTapped), for: .touchUpInside)
        return button
    }()
    
    var resultLabel: UILabel = {
        let label = UILabel()
        label.text = "... дней"
        label.font = UIFont.systemFont(ofSize: 46, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var firstdate = Date.now
    private var seconddate = Date.now
    private var difference = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(lifeDaysLabel)
        view.addSubview(firstDateLabel)
        view.addSubview(firstDatePicker)
        view.addSubview(secondDateLabel)
        view.addSubview(secondDatePicker)
        view.addSubview(resultButton)
        view.addSubview(resultLabel)
        
        NSLayoutConstraint.activate([
            lifeDaysLabel.widthAnchor.constraint(equalToConstant: 350),
            lifeDaysLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lifeDaysLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
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
    
     private func unwindSegue(unwindSegue:UIStoryboardSegue) { }

     @objc private func firstDatePickerChanged(_ sender: UIDatePicker) {
        firstdate = sender.date
    }
    
     @objc private func secondDatePickerChanged(_ sender: UIDatePicker) {
        seconddate = sender.date
    }
    
    @objc private func resultButtonTapped() {
        difference = Calendar.current.dateComponents([.day], from: firstdate, to: seconddate).day ?? 0000
        resultLabel.text = "\(difference) дней"
    }
}

#Preview(traits: .defaultLayout, body: {
    MainTabBarController()
})
