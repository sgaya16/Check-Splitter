//
//  ContentView.swift
//  Check Splitter
//
//  Created by Sara Gaya on 2/7/21.
//

import SwiftUI

struct ContentView: View {
    //swiftUI must use strings to store TextField values
    @State private var amount = ""
    @State private var numPeople = 2
    @State private var tipPercent = 2
    
    let tipPercentages = [10, 15, 20, 0]
    
    var grandTotal: Double {
        let tipChoice = Double(tipPercentages[tipPercent])
        //if the string is invalid to convert to a double, the null value will be replaced with zero
        let checkAmount = Double(amount) ?? 0
        
        let tipValue = checkAmount / 100 * tipChoice
        let total = tipValue + checkAmount
        return total
    }
    
    var totalPerPerson: Double {
        let peopleCount = Double(numPeople + 2)
        let orderTotal = grandTotal
        
        let totalForEach = orderTotal / peopleCount
        return totalForEach
    }
    
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Check amount", text: $amount)
                        .keyboardType(.decimalPad)
                    
                    Picker("Number of people", selection: $numPeople) {
                        ForEach(2 ..< 100) { people in
                            Text("\(people) people")
                        }
                    }
                }
                
                Section(header: Text("How much tip would you like to leave?")) {
                    Picker("Tip percentage", selection: $tipPercent) {
                        ForEach(0 ..< tipPercentages.count) { tip in
                            Text("\(self.tipPercentages[tip])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Grand Total")) {
                    Text("$\(grandTotal, specifier: "%.2f")")
                }
                
                Section(header: Text("Amount per person")) {
                    Text("$\(totalPerPerson, specifier: "%.2f")")
                }
            }
            .navigationBarTitle("Check Splitter")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
