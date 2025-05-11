//
//  CalculatorViewController.swift
//  My First App
//
//  Created by Артем Табенский on 14.11.2024.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    private var numberLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = UIFont.systemFont(ofSize: 48, weight: .bold)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var copyButton: UIButton = {
        let button = UIButton()
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 22, weight: .light, scale: .unspecified)
        let largeDocImage = UIImage(systemName: "doc.on.doc", withConfiguration: largeConfig)
        button.setImage(UIImage(systemName: "doc.on.doc", withConfiguration: largeConfig), for: .normal)
        button.tintColor = .systemGray2
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(copyButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let copiedLabel: UILabel = {
        let label = UILabel()
        label.text = "Скопировано в буфер обмена!"
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = .calculatorGray
        label.layer.cornerRadius = 8
        label.alpha = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let buttonTitles: [[(title: String, tag: Int)]] = [
        [("AC", 10), ("%", 11), ("÷", 12), ("x", 13)],
        [("7", 7), ("8", 8), ("9", 9), ("-", 14)],
        [("4", 4), ("5", 5), ("6", 6), ("+", 15)],
        [("1", 1), ("2", 2), ("3", 3), ("=", 16)],
        [(" ", 19), ("0", 0), (" ", 18), (" ", 17)]
    ]
    
    let buttonStack = UIStackView()
    
    private var buttonViews: [[UIButton]] = []
    
    private var currentNumber: Int {
        get {
            return Int(numberLabel.text ?? "") ?? 0
        }
        set {
            numberLabel.text = String(newValue)
            print(newValue, numberLabel.text)
        }
    }
    private var firstNumber = 0
    private var currentAction: String?
    private var currentSender: UIButton?
    private var numberSwitched = false
    private var canStartAgain = true
    
    private let animationsEngine = Animations()
    private let startColor: CGColor = UIColor.calculatorGray.cgColor
    private let endColor: CGColor = UIColor.calculatorGrayAccent.cgColor
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtons()
        setupDisplay()
        copiedLabel.layer.masksToBounds = true
    }
    
    private func setupButtons() {
        buttonStack.axis = .vertical
        buttonStack.spacing = 12
        buttonStack.distribution = .fillEqually
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonStack)
        
        NSLayoutConstraint.activate([
            buttonStack.heightAnchor.constraint(equalToConstant: 350),
            buttonStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            buttonStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            buttonStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
        
        for row in buttonTitles {
            let rowStack = UIStackView()
            rowStack.axis = .horizontal
            rowStack.spacing = 12
            rowStack.distribution = .fillEqually
            
            var rowButtons: [UIButton] = []
            for buttonTuple in row {
                let button = UIButton()
                button.tag = buttonTuple.tag
                button.accessibilityIdentifier = String()
                button.setTitle(buttonTuple.title, for: .normal)
                button.titleLabel?.font = UIFont.systemFont(ofSize: 28, weight: .bold)
                button.setTitleColor(.white, for: .normal)
                button.backgroundColor = .systemGray4
                button.layer.cornerRadius = 12
                rowButtons.append(button)
                rowStack.addArrangedSubview(button)
                if Range(0...9).contains(buttonTuple.tag) {
                    button.addTarget(self, action: #selector(numberButtonTouchedDown), for: .touchDown)
                    button.addTarget(self, action: #selector(numberButtonTouchedUp), for: .touchUpInside)
                } else if Range(10...16).contains(buttonTuple.tag) {
                    button.addTarget(self, action: #selector(actionButtonTouchedDown), for: .touchDown)
                    button.addTarget(self, action: #selector(actionButtonTouchedUp), for: .touchUpInside)
                } else {
                    button.isEnabled = false
                }
            }
            buttonViews.append(rowButtons)
            buttonStack.addArrangedSubview(rowStack)
        }
    }
    
    private func setupDisplay() {
        view.addSubview(copyButton)
        view.addSubview(numberLabel)
        view.addSubview(copiedLabel)
        
        NSLayoutConstraint.activate([
            copyButton.widthAnchor.constraint(equalToConstant: 35),
            copyButton.heightAnchor.constraint(equalToConstant: 35),
            copyButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            copyButton.bottomAnchor.constraint(equalTo: buttonStack.topAnchor, constant: -40),
            
            numberLabel.widthAnchor.constraint(equalToConstant: 300),
            numberLabel.bottomAnchor.constraint(equalTo: buttonStack.topAnchor, constant: -28),
            numberLabel.trailingAnchor.constraint(equalTo: copyButton.leadingAnchor, constant: -10),
            numberLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            copiedLabel.widthAnchor.constraint(equalToConstant: 290),
            copiedLabel.heightAnchor.constraint(equalToConstant: 40),
            copiedLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            copiedLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func calculate() {
        
        switch currentAction {
        case "/":
            if currentNumber != 0 {
                currentNumber = firstNumber / currentNumber
            } else {
                currentNumber = 404
            }
            break
        case "*":
            currentNumber *= firstNumber
            break
        case "-":
            currentNumber = firstNumber - currentNumber
            break
        case "+":
            currentNumber += firstNumber
        default:
            break
        }
        firstNumber = 0
        currentAction = nil
    }
    
    @objc private func numberButtonTouchedDown(_ sender: UIButton) {
        animationsEngine.animateDownFloat(sender, duration: 0.1)
    }
    
    @objc private func numberButtonTouchedUp(_ sender: UIButton) {
        animationsEngine.animateUpFloat(sender, duration: 0.1)
        if currentNumber == 0 || numberSwitched || canStartAgain {
            currentNumber = sender.tag
        } else {
            currentNumber = Int(String(currentNumber) + String(sender.tag)) ?? 404
        }
        canStartAgain = false
        numberSwitched = false
    }
    
    @objc private func actionButtonTouchedDown(_ sender: UIButton) {
        if ![10, 16].contains(sender.tag) {
            animationsEngine.animateBackgroundColor(sender, color: endColor)
        }
    }
    
    @objc private func actionButtonTouchedUp(_ sender: UIButton) {
        if (currentSender != nil) || sender.tag == 11 {
            animationsEngine.animateBackgroundColor(currentSender!, color: startColor)
        }
        if ![10, 16].contains(sender.tag) {
            animationsEngine.animateBackgroundColor(sender, color: endColor)
            currentSender = sender
        }
        
        if sender.tag == 11 {
            animationsEngine.animateBackgroundColor(currentSender!, color: startColor)
        }
        
        
        switch sender.tag {
        case 10:
            if currentSender != nil {
                animationsEngine.animateBackgroundColor(currentSender!, color: startColor)
            }
            currentNumber = 0
            currentAction = nil
        case 11:
            currentNumber /= 100
            canStartAgain = true
        case 12:
            calculate()
            numberSwitched = true
            animationsEngine.animateBackgroundColor(sender, color: endColor)
            currentAction = "/"
            firstNumber = currentNumber
        case 13:
            calculate()
            numberSwitched = true
            animationsEngine.animateBackgroundColor(sender, color: endColor)
            currentAction = "*"
            firstNumber = currentNumber
        case 14:
            calculate()
            numberSwitched = true
            animationsEngine.animateBackgroundColor(sender, color: endColor)
            currentAction = "-"
            firstNumber = currentNumber
        case 15:
            calculate()
            numberSwitched = true
            animationsEngine.animateBackgroundColor(sender, color: endColor)
            currentAction = "+"
            firstNumber = currentNumber
        case 16:
            if currentSender != nil {
                animationsEngine.animateBackgroundColor(currentSender!, color: startColor)
            }
            currentSender = nil
            calculate()
            canStartAgain = true
        default:
            break
        }
    }
    
    @objc private func copyButtonTapped() {
        UIPasteboard.general.string = numberLabel.text
        copiedLabel.fadeIn(0.3)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.copiedLabel.fadeOut(0.3)
        }
    }
}

#Preview {
    let tabBar = MainTabBarController()
    tabBar.selectedIndex = 3
    return tabBar
}
