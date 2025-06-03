//
//  WordsCounterPresenter.swift
//  AirConverter
//
//  Created by Артем Табенский on 21.05.2025.
//

import UIKit

final class WordsCounterPresenter: NSObject, WordsCounterPresenterProtocol {
    
    var viewController: WordsCounterViewControllerProtocol?
    
    let cyrillicAlphabet = "йцукенгшщзхъёфывапролджэячсмитьбю"
    let latinAlphabet = "qwertyuiopasdfghjklzxcvbnm"
    let numbers = "1234567890"
    
    var wordsCount: Int = 0
    var symbolsCount: Int = 0
    var symbolsNoSpacesCount: Int = 0
    var spacesCount: Int = 0
    var cyrillicCount: Int = 0
    var latinCount: Int = 0
    var numbersCount: Int = 0
    var othersCount: Int = 0
    
    func viewDidLoad() {
        viewController?.textView.delegate = self
    }
    
    func count(text: String) {
        wordsCount = text.split(separator: " ").count
        let symbols = text.count
        symbolsCount = symbols
        symbolsNoSpacesCount = text.filter({$0 != " "}).count
        let spaces = text.filter({$0 == " "}).count
        spacesCount = spaces
        let cyrillic = text.filter({cyrillicAlphabet.contains($0)}).count
        cyrillicCount = cyrillic
        let latin = text.filter({latinAlphabet.contains($0)}).count
        latinCount = latin
        numbersCount = text.filter({numbers.contains($0)}).count
        othersCount = symbols - spaces - cyrillic - latin
        
        let array = [wordsCount, symbolsCount, symbolsNoSpacesCount, spacesCount, cyrillicCount, latinCount, numbersCount, othersCount]
        
        viewController?.updateLabels(numbersArray: array)
    }
    
}

extension WordsCounterPresenter: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
        textView.textColor = .label
    }
}
