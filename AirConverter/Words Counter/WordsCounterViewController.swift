//
//  WordsCountViewController.swift
//  AirConverter
//
//  Created by Артем Табенский on 21.05.2025.
//

import UIKit

final class WordsCounterViewController: UIViewController {
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemGray6
        textField.layer.cornerRadius = 16
        textField.placeholder = "Введите текст"
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        
        //textField.borderStyle = .roundedRect
        textField.clearButtonMode = .whileEditing
        return textField
    }()
    
    private let countButton: UIButton = {
        let button = UIButton()
        button.setTitle("Посчитать", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        button.backgroundColor = .systemCyan
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(countButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let resultsStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = Constants.stackViewSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let labelsTitles: [String] = [
        "Всего слов", "Всего символов", "Всего символов без пробелов", "Пробелов",
        "Всего кириллических символов", "Всего латинских символов","Всего цифр", "Остальных символов"
    ]
    
    private let wordsCounterLabel = UILabel()
    private let symbolsCounterLabel = UILabel()
    private let symbolsNoSpacesCounterLabel = UILabel()
    private let spacesCounterLabel = UILabel()
    private let cyrillicCounterLabel = UILabel()
    private let latinCounterLabel = UILabel()
    private let numbersCounterLabel = UILabel()
    private let othersCounterLabel = UILabel()
    
    private var counterLabelsArray: [UILabel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        counterLabelsArray = [
            wordsCounterLabel, symbolsCounterLabel, symbolsNoSpacesCounterLabel, spacesCounterLabel,
            cyrillicCounterLabel, latinCounterLabel, numbersCounterLabel, othersCounterLabel
        ]
        
        setupViews()
        activateConstraints()
    }
    
    private func setupViews() {
        [textField, countButton].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(view)
        }
    }
    
    private func activateConstraints() {
        NSLayoutConstraint.activate([
            textField.heightAnchor.constraint(equalToConstant: 200),
            textField.leadingAnchor.constraint(equalTo:  view.leadingAnchor, constant: 15),
            textField.trailingAnchor.constraint(equalTo:  view.trailingAnchor, constant: -15),
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            countButton.heightAnchor.constraint(equalToConstant: 50),
            countButton.leadingAnchor.constraint(equalTo:  view.leadingAnchor, constant: 15),
            countButton.trailingAnchor.constraint(equalTo:  view.trailingAnchor, constant: -15),
            countButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            countButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20)
        ])
    }
    
    @objc private func countButtonTapped() {
        print("🥸")
    }
}
