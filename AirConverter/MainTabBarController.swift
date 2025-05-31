//
//  MainTabBarController.swift
//  AirConverter
//
//  Created by Артем Табенский on 10.05.2025.
//

import UIKit

final class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabs()
    }
    
    private func setupTabs() {
        
        let swiftUINavigationVC = createNav(
            title: NSLocalizedString("converter", comment: ""),
            image: UIImage(systemName: "dollarsign.arrow.trianglehead.counterclockwise.rotate.90")!,
            leftButtonItem: nil,
            rightButtonItem: nil,
            vc: ConverterViewController()
        )
        
        let lifeDaysOneVC = self.createNav(
            title: NSLocalizedString("daysCalculator", comment: ""),
            image: UIImage(systemName: "calendar")!,
            leftButtonItem: nil,
            rightButtonItem: nil,
            vc: DaysCalculatorViewController()
        )
        
        let lifeDaysTwoVC = self.createNav(
            title: NSLocalizedString("lifeDays", comment: ""),
            image: UIImage(systemName: "birthday.cake")!,
            leftButtonItem: nil,
            rightButtonItem: nil,
            vc: BirthdayCalculator()
        )
        
        let wordsCounterVC = self.createNav(
            title: NSLocalizedString("textAnalysis", comment: ""),
            image: UIImage(systemName: "text.document")!,
            leftButtonItem: nil,
            rightButtonItem: nil,
            vc: WordsCounterViewController()
        )
        
        let calculatorVC = self.createNav(
            title: NSLocalizedString("calculator", comment: ""),
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
    tabBar.selectedIndex = 0
    return tabBar
})
