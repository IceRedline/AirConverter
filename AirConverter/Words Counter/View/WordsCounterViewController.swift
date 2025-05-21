//
//  WordsCountViewController.swift
//  AirConverter
//
//  Created by Артем Табенский on 21.05.2025.
//

import UIKit

final class WordsCounterViewController: UIViewController, WordsCounterViewControllerProtocol {
    
    var presenter: WordsCounterPresenterProtocol?
    private let animationsEngine = Animations()
    
    private let textView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .systemGray6
        textView.layer.cornerRadius = 16
        //textField.placeholder = "Введите текст"
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: textView.frame.height))
        //textField.leftView = paddingView

        return textView
    }()
    
    private let countButton: UIButton = {
        let button = UIButton()
        button.setTitle("Посчитать", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        button.backgroundColor = .systemCyan
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(countButtonTouchedDown(_:)), for: .touchDown)
        button.addTarget(self, action: #selector(countButtonTouchedUpInside(_:)), for: .touchUpInside)
        return button
    }()
    
    private let resultsStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = Constants.stackViewSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let wordsCounterLabel = UILabel()
    private let symbolsCounterLabel = UILabel()
    private let symbolsNoSpacesCounterLabel = UILabel()
    private let spacesCounterLabel = UILabel()
    private let cyrillicCounterLabel = UILabel()
    private let latinCounterLabel = UILabel()
    private let numbersCounterLabel = UILabel()
    private let othersCounterLabel = UILabel()
    
    let labelsTitles: [String] = [
        "Всего слов", "Всего символов", "Всего символов без пробелов", "Пробелов",
        "Всего кириллических символов", "Всего латинских символов","Всего цифр", "Остальных символов"
    ]
    
    private var counterLabelsArray: [UILabel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure(WordsCounterPresenter())
        
        counterLabelsArray = [
            wordsCounterLabel, symbolsCounterLabel, symbolsNoSpacesCounterLabel, spacesCounterLabel,
            cyrillicCounterLabel, latinCounterLabel, numbersCounterLabel, othersCounterLabel
        ]
        
        setupViews()
        setupVStacks()
        activateConstraints()
    }
    
    func configure(_ presenter: WordsCounterPresenterProtocol) {
        self.presenter = presenter
        self.presenter?.viewController = self
    }
    
    private func setupViews() {
        [textView, countButton].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(view)
        }
        
    }
    
    private func activateConstraints() {
        NSLayoutConstraint.activate([
            textView.heightAnchor.constraint(equalToConstant: 200),
            textView.leadingAnchor.constraint(equalTo:  view.leadingAnchor, constant: Constants.defaultPadding),
            textView.trailingAnchor.constraint(equalTo:  view.trailingAnchor, constant: -Constants.defaultPadding),
            textView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            countButton.heightAnchor.constraint(equalToConstant: 50),
            countButton.leadingAnchor.constraint(equalTo:  view.leadingAnchor, constant: Constants.defaultPadding),
            countButton.trailingAnchor.constraint(equalTo:  view.trailingAnchor, constant: -Constants.defaultPadding),
            countButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            countButton.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 20),
            resultsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.defaultPadding),
            resultsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.defaultPadding),
            resultsStackView.topAnchor.constraint(equalTo: countButton.bottomAnchor, constant: 20)
        ])
    }
    
    private func setupVStacks() {
        for i in 0..<8 {
            let hStack = UIStackView()
            hStack.axis = .horizontal
            hStack.spacing = Constants.stackViewSpacing
            hStack.translatesAutoresizingMaskIntoConstraints = false
            
            let textLabelView = UIView()
            let textLabel = UILabel()
            
            textLabel.text = labelsTitles[i]
            textLabelView.addSubview(textLabel)
            
            let counterLabelView = UIView()
            guard let counterLabel = counterLabelsArray?[i] else { return }
            counterLabel.text = "0"
            counterLabel.textAlignment = .right
            counterLabelView.addSubview(counterLabel)
            
            [textLabelView, textLabel, counterLabelView, counterLabel].forEach { view in
                view.translatesAutoresizingMaskIntoConstraints = false
                view.backgroundColor = .systemGray6
                view.layer.cornerRadius = 8
            }
            
            NSLayoutConstraint.activate([
                hStack.heightAnchor.constraint(equalToConstant: 35),
                textLabel.leadingAnchor.constraint(equalTo: textLabelView.leadingAnchor, constant: 10),
                textLabel.centerYAnchor.constraint(equalTo: textLabelView.centerYAnchor),
                textLabelView.widthAnchor.constraint(equalToConstant: 280),
                counterLabel.trailingAnchor.constraint(equalTo: counterLabelView.trailingAnchor, constant: -10),
                counterLabel.centerYAnchor.constraint(equalTo: counterLabelView.centerYAnchor),
            ])
            
            hStack.addArrangedSubview(textLabelView)
            hStack.addArrangedSubview(counterLabelView)
            
           resultsStackView.addArrangedSubview(hStack)
        }
        view.addSubview(resultsStackView)
    }
    
    @objc private func countButtonTouchedDown(_ sender: UIButton) {
        animationsEngine.animateDownFloat(sender)
    }
    
    @objc private func countButtonTouchedUpInside(_ sender: UIButton) {
        animationsEngine.animateUpFloat(sender)
        guard let text = textView.text else { return }
        presenter?.count(text: text)
    }
    
    func updateLabels(numbersArray: [Int]) {
        for i in 0..<8 {
            counterLabelsArray?[i].text = String(numbersArray[i])
        }
    }
}

#Preview(body: {
    let tabBar = MainTabBarController()
    tabBar.selectedIndex = 3
    return tabBar
})
