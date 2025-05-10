//
//  CurrencyInput.swift
//  AirConverter
//
//  Created by Артем Табенский on 08.05.2025.
//

import SwiftUI

struct CurrencyInput: View {
    
    var currency: Currency
    var amount: Double
    var converter: (Double) -> Void
    let tapHandler: () -> Void
    
    var numberFormatter: NumberFormatter = {
        var nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.usesGroupingSeparator = false
        nf.maximumFractionDigits = 2
        return nf
    }()
    
    var body: some View {
        
        let topBinding = Binding<Double>(
            get: {
                amount
            },
            set: {
                converter($0)
            }
        )
        
        HStack {
            
            VStack {
                Text(currency.flag)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
                
                Text(currency.rawValue)
                    .font(.title2)
            }
            .frame(height: 100)
            .onTapGesture(perform: tapHandler)
            
            TextField("", value: topBinding, formatter: numberFormatter)
                .font(.largeTitle)
                .multilineTextAlignment(.trailing)
                .minimumScaleFactor(0.5)
                .keyboardType(.numberPad)
        }
    }
}

#Preview {
    CurrencyInput(
        currency: .RUR,
        amount: 1000,
        converter: { _ in },
        tapHandler: {}
    )
}
