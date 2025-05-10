//
//  ConverterView.swift
//  AirConverter
//
//  Created by Артем Табенский on 08.05.2025.
//

import SwiftUI

struct ConverterView: View {
    
    @EnvironmentObject var viewModel: ConverterViewModel
    @State private var isPickerPresented = false
    
    var body: some View {
        
        List {
            CurrencyInput(currency: viewModel.topCurrency, amount: viewModel.topAmount, converter: viewModel.setTopAmount, tapHandler: { isPickerPresented.toggle() })
            
            CurrencyInput(currency: viewModel.bottomCurrency, amount: viewModel.bottomAmount, converter: viewModel.setBottomAmount, tapHandler: { isPickerPresented.toggle() })
        }
        .foregroundColor(.accentColor)
        .onTapGesture {
            hideKeyboard()
        }
        .sheet(isPresented: $isPickerPresented) {
            
            VStack(spacing: 16) {
                
                Spacer()
                
                RoundedRectangle(cornerRadius: 3)
                    .fill(.secondary)
                    .frame(width: 60, height: 6)
                    .onTapGesture {
                        isPickerPresented = false
                    }
                
                HStack{
                    
                    CurrencyPicker(currency: $viewModel.topCurrency, onChange: { _ in didChangeTopCurrency() })
                    CurrencyPicker(currency: $viewModel.bottomCurrency, onChange: { _ in didChangeBottomCurrency() })
                }
            }
            .presentationDetents([.fraction(0.3)])
        }
    }
    
    private func didChangeTopCurrency() {
        viewModel.updateTopAmount()
    }
    
    private func didChangeBottomCurrency() {
        viewModel.updateBottomAmount()
    }
}

struct ConverterView_Previews: PreviewProvider {
    static var previews: some View {
        ConverterView()
            .environmentObject(ConverterViewModel())
    }
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
