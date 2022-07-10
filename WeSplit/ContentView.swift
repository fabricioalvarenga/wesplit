//
//  ContentView.swift
//  WeSplit
//
//  Created by FABRICIO ALVARENGA on 27/06/22.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
//    let tipPercentages = [10, 15, 20, 25, 0]
    let tipPercentages = (0..<101)
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount * (tipSelection / 100)
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var totalAmount: Double {
        checkAmount + (checkAmount * Double(tipPercentage) / 100)
    }
    
    let currencyFormatter: FloatingPointFormatStyle<Double>.Currency = .currency(code: Locale.current.currencyCode ?? "USD")
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: currencyFormatter)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section {
/*                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)*/
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                        
                    }
                } header: {
                    Text("How much tip do you want do leave?")
                }
                
                Section {
                    Text(totalPerPerson, format: currencyFormatter)
                } header: {
                    Text("Amount per Person")
                }
                
                Section {
                    Text(totalAmount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                        .foregroundColor((tipPercentage == 0 ? .red : .primary))
                } header: {
                    Text("Total Amount")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
