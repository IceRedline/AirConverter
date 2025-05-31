//
//  ConverterViewPresenterProtocol.swift
//  AirConverter
//
//  Created by Артем Табенский on 27.05.2025.
//

import UIKit

protocol ConverterViewControllerProtocol {
    
    var presenter: ConverterPresenterProtocol? { get }
    
    var tableView: UITableView { get }
}
