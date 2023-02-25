//
//  ContentView.swift
//  BetterRest
//
//  Created by Yashraj jadhav on 06/01/23.
//
import CoreML
import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    @State private var calculatedBedtime: String?
    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""

    private static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("When do you want to wake up?").font(.headline)) {
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .datePickerStyle(WheelDatePickerStyle())
                }
                Section(header: Text("Desired amount of sleep").font(.headline)) {
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                }
                Section(header: Text("Daily coffee intake").font(.headline)) {
                    Stepper(coffeeAmount == 1 ? "1 cup" : "\(coffeeAmount) cups", value: $coffeeAmount, in: 1...20)
                }
                Section(header: Text("Your ideal bedtime is").font(.headline)) {
                    if let calculatedBedtime = calculatedBedtime {
                        Text(calculatedBedtime)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Calculate") {
                        if let calculatedBedtime = calculateBedtime(wakeUp: wakeUp, sleepAmount: sleepAmount, coffeeAmount: coffeeAmount) {
                            self.calculatedBedtime = calculatedBedtime
                        } else {
                            alertTitle = "Error"
                            alertMessage = "Sorry, there was a problem calculating your bedtime."
                            showingAlert = true
                        }
                    }
                }
            }.toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Reset") {
                        wakeUp = Self.defaultWakeTime
                        sleepAmount = 8.0
                        coffeeAmount = 1
                        calculatedBedtime = nil
                    }
                }
            }

            
            
            .alert(alertTitle, isPresented: $showingAlert) {
                Button("OK") { }
            } message: {
                Text(alertMessage)
            }
            
        }
        .onAppear {
            self.calculatedBedtime
        }
    }


}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



