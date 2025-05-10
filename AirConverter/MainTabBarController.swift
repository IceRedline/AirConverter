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
        /*
        let swiftUIView = MySwiftUIView()
        let swiftUIController = UIHostingController(rootView: swiftUIView)
        swiftUIController.tabBarItem = UITabBarItem(title: "SwiftUI", image: UIImage(systemName: "star"), tag: 1)
         */
        let lifeDaysOneVC = self.createNav(
            title: "Калькулятор дней",
            image: UIImage(systemName: "calendar")!,
            leftButtonItem: nil,
            rightButtonItem: nil,
            vc: LifeDaysOne()
        )
        
        let lifeDaysTwoVC = self.createNav(
            title: "Дни жизни",
            image: UIImage(systemName: "birthday.cake")!,
            leftButtonItem: nil,
            rightButtonItem: nil,
            vc: LifeDaysTwo()
        )
        
        self.setViewControllers([lifeDaysOneVC, lifeDaysTwoVC], animated: true)
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
