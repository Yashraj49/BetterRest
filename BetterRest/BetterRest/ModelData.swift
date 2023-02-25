//
//  ModelData.swift
//  BetterRest
//
//  Created by Yashraj jadhav on 24/02/23.
//

import Foundation
import CoreML

func calculateBedtime(wakeUp: Date, sleepAmount: Double, coffeeAmount: Int) -> String? {
    do {
        let config = MLModelConfiguration()
        let model = try SleepCalculator(configuration: config)

        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.minute ?? 0) * 60

        let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))

        let sleepTime = wakeUp - prediction.actualSleep
        return sleepTime.formatted(date: .omitted, time: .shortened)
    } catch {
        return nil
    }
}



    
