//
//  HealthManager.swift
//  Data Deck
//
//  Created by Dean Divizio on 7/18/24.
//

import Foundation
import HealthKit

class HealthManager: ObservableObject {
    
    let healthStore = HKHealthStore()
    
    init() {
        let weightType = HKQuantityType(.bodyMass)
        let bmiType = HKQuantityType(.bodyMassIndex)
        let bodyFatType = HKQuantityType(.bodyFatPercentage)
        let activeCalType = HKQuantityType(.activeEnergyBurned)
        let passiveCalType = HKQuantityType(.basalEnergyBurned)
        
        let healthTypes: Set = [weightType, bmiType, bodyFatType, activeCalType, passiveCalType]
        
        Task {
            do {
                try await healthStore.requestAuthorization(toShare: [], read: healthTypes)
            } catch {
                print("error fetching HKdata")
            }
        }
    }
}

