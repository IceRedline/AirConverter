//
//  ConverterView.swift
//  AirConverter
//
//  Created by Артем Табенский on 08.05.2025.
//

import SwiftUI

class ConverterViewController: UIViewController, ConverterViewControllerProtocol {
    
    var presenter: ConverterPresenterProtocol?
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup(presenter: ConverterPresenter())
        setupViews()
        setupConstraints()
    }
    
    private func setup(presenter: ConverterPresenterProtocol) {
        self.presenter = presenter
        self.presenter?.view = self
    }
    
    private func setupViews() {
        tableView.register(ConverterTableViewCell.self, forCellReuseIdentifier: "ConverterTableViewCell")
        tableView.backgroundColor = .red
        tableView.layer.cornerRadius = 16
        tableView.delegate = presenter
        tableView.dataSource = presenter
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.heightAnchor.constraint(equalToConstant: 240),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.defaultPadding),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.defaultPadding),
        ])
    }
}
