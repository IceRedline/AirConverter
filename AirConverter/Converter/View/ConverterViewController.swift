//
//  ConverterView.swift
//  AirConverter
//
//  Created by Артем Табенский on 08.05.2025.
//

import UIKit
import DGCharts

class ConverterViewController: UIViewController, ConverterViewControllerProtocol {
    
    var presenter: ConverterPresenterProtocol?
    
    var tableView = UITableView()
    var chart = LineChartView()
    var chartLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup(presenter: ConverterPresenter())
        setupViews()
        setupConstraints()
        presenter?.viewDidLoad()
    }
    
    private func setup(presenter: ConverterPresenterProtocol) {
        self.presenter = presenter
        self.presenter?.view = self
    }
    
    private func setupViews() {
        tableView.register(ConverterTableViewCell.self, forCellReuseIdentifier: "ConverterTableViewCell")
        tableView.layer.cornerRadius = 16
        tableView.delegate = presenter
        tableView.dataSource = presenter
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        setupChart()
        view.addSubview(chartLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.heightAnchor.constraint(equalToConstant: 240),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.defaultPadding),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.defaultPadding),
            chart.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.defaultPadding),
            chart.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.defaultPadding),
            chart.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 75),
            chart.heightAnchor.constraint(equalToConstant: 200),
            chartLabel.topAnchor.constraint(equalTo: chart.bottomAnchor, constant: Constants.defaultPadding),
            chartLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setupChart() {
        chart.translatesAutoresizingMaskIntoConstraints = false
        
        // отключаем координатную сетку
         chart.xAxis.drawGridLinesEnabled = false
         chart.leftAxis.drawGridLinesEnabled = false
         chart.rightAxis.drawGridLinesEnabled = false
         chart.drawGridBackgroundEnabled = false
         // отключаем подписи к осям
         chart.xAxis.drawLabelsEnabled = false
         chart.leftAxis.drawLabelsEnabled = false
         chart.rightAxis.drawLabelsEnabled = false
         // отключаем легенду
         chart.legend.enabled = false
         // отключаем зум
         chart.pinchZoomEnabled = false
         chart.doubleTapToZoomEnabled = false
         // убираем артефакты вокруг области графика
         chart.xAxis.enabled = false
         chart.leftAxis.enabled = false
         chart.rightAxis.enabled = false
         chart.drawBordersEnabled = false
         chart.minOffset = 15
        
        view.addSubview(chart)
    }
    
    func updateChart(dataSet: LineChartDataSet) {
        dataSet.mode = .cubicBezier
        dataSet.lineWidth = 3
        dataSet.drawFilledEnabled = true
        dataSet.valueFont = UIFont.systemFont(ofSize: 10)
        
        let gradientColors = [UIColor.systemCyan.withAlphaComponent(1).cgColor,
                              UIColor.systemCyan.withAlphaComponent(0.2).cgColor,
                              UIColor.systemCyan.withAlphaComponent(0).cgColor] as CFArray
        let colorLocations:[CGFloat] = [0, 0.79, 1]
        
        if let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(),
                                     colors: gradientColors,
                                     locations: colorLocations) {
            
            dataSet.fill = LinearGradientFill(gradient: gradient, angle: 270)
            dataSet.drawFilledEnabled = true
            
            let data = LineChartData(dataSet: dataSet)
            chart.data = data
        }
    }
    
    func updateLabel(fromCurrency: String, toCurrency: String) {
        chartLabel.text = "\(fromCurrency) - \(toCurrency) chart (10 days)"
    }
    
    func presentSheet(currentCurrencies: [String]) {
        let controller = SheetViewController(startCurrencies: currentCurrencies)
        if let sheetController = controller.sheetPresentationController {
            sheetController.detents = [.medium()]
            sheetController.prefersGrabberVisible = true
        }
        
        controller.onCurrencySelected = { [weak self] currencyFrom, currencyTo in
            self?.presenter?.currenciesChanged(fromCurrency: currencyFrom, toCurrency: currencyTo)
        }
        
        controller.onDismiss = { [weak self] in
            self?.presenter?.loadExchangeRates()
        }
        
        present(controller, animated: true)
    }
}

