import Foundation
import HealthKit

class HealthManager: ObservableObject {
    let healthStore = HKHealthStore()
    
    @Published var weights: [Double] = []
    @Published var bmis: [Double] = []
    @Published var bodyFats: [Double] = []
    @Published var activeEnergy: (current: Double, previous: Double)? = nil
    @Published var basalEnergy: (current: Double, previous: Double)? = nil
    @Published var totalEnergy: (current: Double, previous: Double)? = nil
    
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
                print("Authorization successful")
                fetchHealthData()
            } catch {
                print("Error fetching HK data: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchMostRecentValues(for identifier: HKQuantityTypeIdentifier, unit: HKUnit, limit: Int = 2, completion: @escaping ([Double]?) -> Void) {
        guard let quantityType = HKQuantityType.quantityType(forIdentifier: identifier) else {
            completion(nil)
            return
        }
        
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
        
        let query = HKSampleQuery(sampleType: quantityType, predicate: nil, limit: limit, sortDescriptors: [sortDescriptor]) { (query, result, error) in
            guard let results = result as? [HKQuantitySample], error == nil else {
                print("Failed to fetch \(identifier): \(String(describing: error))")
                completion(nil)
                return
            }
            
            let values = results.map { $0.quantity.doubleValue(for: unit) }
            print("\(identifier) values: \(values)")
            completion(values)
        }
        
        healthStore.execute(query)
    }
    
    func fetchEnergyData(for identifier: HKQuantityTypeIdentifier, unit: HKUnit, completion: @escaping ((current: Double, previous: Double)?) -> Void) {
        guard let quantityType = HKQuantityType.quantityType(forIdentifier: identifier) else {
            completion(nil)
            return
        }
        
        let calendar = Calendar.current
        let now = Date()
        
        guard let startOfToday = calendar.startOfDay(for: now) as Date?,
              let startOfYesterday = calendar.date(byAdding: .day, value: -1, to: startOfToday),
              let startOfDayBeforeYesterday = calendar.date(byAdding: .day, value: -2, to: startOfToday) else {
            completion(nil)
            return
        }
        
        print("Start of Today: \(startOfToday)")
        print("Start of Yesterday: \(startOfYesterday)")
        print("Start of Day Before Yesterday: \(startOfDayBeforeYesterday)")
        
        let yesterdayPredicate = HKQuery.predicateForSamples(withStart: startOfYesterday, end: startOfToday, options: .strictStartDate)
        let dayBeforeYesterdayPredicate = HKQuery.predicateForSamples(withStart: startOfDayBeforeYesterday, end: startOfYesterday, options: .strictStartDate)
        
        var yesterdayEnergy: Double = 0
        var dayBeforeYesterdayEnergy: Double = 0
        
        let group = DispatchGroup()
        
        group.enter()
        let yesterdayQuery = HKStatisticsQuery(quantityType: quantityType, quantitySamplePredicate: yesterdayPredicate, options: .cumulativeSum) { (_, result, error) in
            if let sum = result?.sumQuantity() {
                yesterdayEnergy = sum.doubleValue(for: unit)
                print("Yesterday's \(identifier): \(yesterdayEnergy) \(unit.unitString)")
            } else {
                print("Error fetching yesterday's data for \(identifier): \(String(describing: error))")
            }
            group.leave()
        }
        healthStore.execute(yesterdayQuery)
        
        group.enter()
        let dayBeforeYesterdayQuery = HKStatisticsQuery(quantityType: quantityType, quantitySamplePredicate: dayBeforeYesterdayPredicate, options: .cumulativeSum) { (_, result, error) in
            if let sum = result?.sumQuantity() {
                dayBeforeYesterdayEnergy = sum.doubleValue(for: unit)
                print("Day Before Yesterday's \(identifier): \(dayBeforeYesterdayEnergy) \(unit.unitString)")
            } else {
                print("Error fetching day before yesterday's data for \(identifier): \(String(describing: error))")
            }
            group.leave()
        }
        healthStore.execute(dayBeforeYesterdayQuery)
        
        group.notify(queue: .main) {
            print("Yesterday's energy: \(yesterdayEnergy), Day before yesterday's energy: \(dayBeforeYesterdayEnergy)")
            completion((current: yesterdayEnergy, previous: dayBeforeYesterdayEnergy))
        }
    }
    func calculateTotalEnergy() {
        guard let activeEnergy = self.activeEnergy, let basalEnergy = self.basalEnergy else {
            return
        }
        
        let currentTotal = activeEnergy.current + basalEnergy.current
        let previousTotal = activeEnergy.previous + basalEnergy.previous
        
        self.totalEnergy = (current: currentTotal, previous: previousTotal)
    }

    
    func fetchHealthData() {
        fetchMostRecentValues(for: .bodyMass, unit: HKUnit.pound()) { values in
            DispatchQueue.main.async {
                self.weights = values ?? []
                print("Fetched weights: \(self.weights)")
            }
        }
        
        fetchMostRecentValues(for: .bodyMassIndex, unit: HKUnit.count()) { values in
            DispatchQueue.main.async {
                self.bmis = values ?? []
                print("Fetched BMIs: \(self.bmis)")
            }
        }
        
        fetchMostRecentValues(for: .bodyFatPercentage, unit: HKUnit.percent()) { values in
            DispatchQueue.main.async {
                self.bodyFats = values ?? []
                print("Fetched body fat percentages: \(self.bodyFats)")
            }
        }
        
        fetchEnergyData(for: .activeEnergyBurned, unit: HKUnit.kilocalorie()) { values in
            DispatchQueue.main.async {
                self.activeEnergy = values
                print("Fetched active energies: \(String(describing: self.activeEnergy))")
                self.calculateTotalEnergy() // Calculate total energy after fetching active energy
            }
        }
        
        fetchEnergyData(for: .basalEnergyBurned, unit: HKUnit.kilocalorie()) { values in
            DispatchQueue.main.async {
                self.basalEnergy = values
                print("Fetched basal energies: \(String(describing: self.basalEnergy))")
                self.calculateTotalEnergy() // Calculate total energy after fetching basal energy
            }
        }
    }
}
