//
//  ConverterViewPresenterProtocol.swift
//  AirConverter
//
//  Created by Артем Табенский on 27.05.2025.
//

import UIKit
import DGCharts

protocol ConverterViewControllerProtocol {
    
    var presenter: ConverterPresenterProtocol? { get }
    var tableView: UITableView { get }
    var chart: LineChartView { get }
    
    func presentSheet(currentCurrencies: [String])
    func updateChart(dataSet: LineChartDataSet)
    func updateLabel(fromCurrency: String, toCurrency: String)
}
