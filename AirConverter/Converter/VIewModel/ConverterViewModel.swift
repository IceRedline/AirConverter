//
//  ConverterViewModel.swift
//  AirConverter
//
//  Created by Артем Табенский on 08.05.2025.
//

import Foundation
import Combine

final class ConverterViewModel: ObservableObject {
    
    private var model = ConverterModel()
    
    enum State {
        case loading
        case content
        case error
    }
    
    @Published var state: State = .content
    
    @Published var topCurrency: Currency = .CNY
    @Published var bottomCurrency: Currency = .RUR
    
    @Published var topAmount: Double = 0
    @Published var bottomAmount: Double = 0
    
    // Загрузчик данных
    private let loader: MoexDataLoader
    
    // Хранилище подписок Combine
    private var subscriptions = Set<AnyCancellable>()
    
    // Инициализатор, который принимает переменную загрузчика
    init(with loader: MoexDataLoader = MoexDataLoader()) {
        self.loader = loader
        fetchData()
    }
    
    // Функция, которая запускает запрос данных с помощью загрузчика
    // и устанавливает переменную состояния state в зависимости
    // от результата загрузки
    private func fetchData() {
        loader.fetch().sink(
            receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                if case .failure = completion {
                    self.state = .error
                }
            },
            receiveValue: { [weak self] currencyRates in
                guard let self = self else { return }
                self.model.setCurrencyRates(currencyRates)
                self.state = .content
            })
        .store(in: &subscriptions)
    }
    
    func setTopAmount(_ amount: Double) {
        topAmount = amount
        updateBottomAmount()
    }
    
    func setBottomAmount(_ amount: Double) {
        bottomAmount = amount
        updateTopAmount()
    }
    
    func updateBottomAmount() {
        let topAmount = CurrencyAmount(currency: topCurrency, amount: topAmount)
        bottomAmount = model.convert(topAmount, to: bottomCurrency)
    }
    
    func updateTopAmount() {
        let bottomAmount = CurrencyAmount(currency: bottomCurrency, amount: bottomAmount)
        topAmount = model.convert(bottomAmount, to: topCurrency)
    }
}
