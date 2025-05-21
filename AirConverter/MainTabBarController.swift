//
//  MainTabBarController.swift
//  AirConverter
//
//  Created by Артем Табенский on 10.05.2025.
//

import UIKit
import SwiftUI

final class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabs()
    }
    
    private func setupTabs() {
        
        let converterViewModel = ConverterViewModel()
        let converterView = ConverterView().environmentObject(converterViewModel)
        let hostingVC = UIHostingController(rootView: converterView)
        
        let swiftUINavigationVC = createNav(
            title: "Конвертер",
            image: UIImage(systemName: "dollarsign.arrow.trianglehead.counterclockwise.rotate.90")!,
            leftButtonItem: nil,
            rightButtonItem: nil,
            vc: hostingVC
        )
        
        let lifeDaysOneVC = self.createNav(
            title: "Калькулятор дней",
            image: UIImage(systemName: "calendar")!,
            leftButtonItem: nil,
            rightButtonItem: nil,
            vc: DaysCalculatorViewController()
        )
        
        let lifeDaysTwoVC = self.createNav(
            title: "Дни жизни",
            image: UIImage(systemName: "birthday.cake")!,
            leftButtonItem: nil,
            rightButtonItem: nil,
            vc: BirthdayCalculator()
        )
        
        let wordsCounterVC = self.createNav(
            title: "Анализ текста",
            image: UIImage(systemName: "text.document")!,
            leftButtonItem: nil,
            rightButtonItem: nil,
            vc: WordsCounterViewController()
        )
        
        let calculatorVC = self.createNav(
            title: "Калькулятор",
            image: UIImage(systemName: "plus.forwardslash.minus")!,
            leftButtonItem: nil,
            rightButtonItem: nil,
            vc: CalculatorViewController()
        )
        
        self.setViewControllers([swiftUINavigationVC, lifeDaysOneVC, lifeDaysTwoVC, wordsCounterVC, calculatorVC], animated: true)
    }
    
    private func createNav(title: String, image: UIImage, leftButtonItem: UIBarButtonItem?, rightButtonItem: UIBarButtonItem?, vc: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: vc)
        nav.navigationBar.prefersLargeTitles = true
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        nav.viewControllers.first?.navigationItem.title = title
        nav.viewControllers.first?.navigationItem.leftBarButtonItem = leftButtonItem
        nav.viewControllers.first?.navigationItem.rightBarButtonItem = rightButtonItem
        nav.viewControllers.first?.navigationItem.leftBarButtonItem?.tintColor = .black
        nav.viewControllers.first?.navigationItem.rightBarButtonItem?.tintColor = .black
        return nav
    }
}

#Preview(body: {
    let tabBar = MainTabBarController()
    tabBar.selectedIndex = 3
    return tabBar
})
