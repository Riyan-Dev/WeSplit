//
//  ContentView.swift
//  WeSplit
//
//  Created by Muhammad Riyan on 17/04/2020.
//  Copyright © 2020 Muhammad Riyan. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var CheckAmount = ""
    @State private var PeopleNumber  = 2
    @State private var TipPercentage = 2
    
    let TipPercentages = [5, 10, 15, 20, 0]
    
    var TotalPerPerson: Double {
        let PeopleCount = Double(PeopleNumber + 2)
        let tipSelection = Double(TipPercentages[TipPercentage])
        let orderAmount = Double(CheckAmount) ?? 0
        
        let tip = (tipSelection/100) * orderAmount
        let total = tip + orderAmount
        let AmountPerPerson = total/PeopleCount
        
        return AmountPerPerson
    }
    
    var GrandTotal: Double {
        let tipSelection = Double(TipPercentages[TipPercentage])
        let orderAmount = Double(CheckAmount) ?? 0
        
        let tip = (tipSelection/100) * orderAmount
        let total = tip + orderAmount
        
        return total
    }
    
    var amountColorRed: Bool {
        if Double(TipPercentages[TipPercentage]) == 0 {
            return true
        } else {
            return false
        }
    }
    
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField ("Enter Check Amount", text: $CheckAmount)
                        .keyboardType(.decimalPad)
                    Picker ("Number off people", selection: $PeopleNumber) {
                        ForEach (2..<100) {
                            Text ("\($0) people")
                        }
                    }
                }
                
                Section (header: Text("How much tip do you want to leave").bold()) {
                    Picker ("Tip percentage", selection: $TipPercentage) {
                        ForEach (0 ..< TipPercentages.count) {
                            Text("\(self.TipPercentages[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Total Amount").bold())  {
                    Text ("PKR \(GrandTotal, specifier: "%.2f")")
                        .foregroundColor(amountColorRed ? .red : .primary)
                }
                
                Section(header: Text("Total Amount Per Person").bold())  {
                    Text ("PKR \(TotalPerPerson, specifier: "%.2f")")
                    .foregroundColor(amountColorRed ? .red : .black)
                }
            }
        .navigationBarTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
