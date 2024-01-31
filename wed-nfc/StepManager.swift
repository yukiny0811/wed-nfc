//
//  StepManager.swift
//  wed-nfc
//
//  Created by yuta kodama on 2024/01/31.
//

import Foundation
import HealthKit

class StepManager {
    
    static func getStepCount(startDate: Date, endDate: Date) async throws -> Int {
        
        let healthKitStore = HKHealthStore()
        let quantityType = HKSampleType.quantityType(forIdentifier: .stepCount)!
        let periodPredicate = HKQuery.predicateForSamples(
            withStart: startDate,
            end: endDate
        )
        let predicate = HKSamplePredicate.quantitySample(
            type: quantityType,
            predicate: periodPredicate
        )
        let descriptor = HKSampleQueryDescriptor(
            predicates: [predicate],
            sortDescriptors: []
        )
        let results = try await descriptor.result(for: healthKitStore)
        let sum = results.reduce(0) {$0 + $1.quantity.doubleValue(for: .count())}
        print(sum)
        return Int(sum)
    }
    
}
