//
//  HealthManager.swift
//  Batch
//
//  Created by Vijay Singh on 09/03/24.
//

import Foundation
import HealthKit


class HealthManager{
    
    static let shared = HealthManager()
    
    private let healthStore = HKHealthStore()

    private init (){}
    
    func isHealthKitAuthorised() -> Bool{
        guard HKHealthStore.isHealthDataAvailable() else{ return false}
        return true
    }
    
    func requestHealthkitPermissions(completion: @escaping (Bool, String?) -> Void) {
        guard HKHealthStore.isHealthDataAvailable() else {
            completion(false, "No Health Data Available")
            return
        }
        let sampleTypesToRead = Set([
            HKObjectType.quantityType(forIdentifier: .heartRate)!,
            HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!,
            HKObjectType.quantityType(forIdentifier: .stepCount)!,
            HKObjectType.categoryType(forIdentifier: .sleepAnalysis)!,
        ])
        
        healthStore.requestAuthorization(toShare: nil, read: sampleTypesToRead) { (success, error) in
            if error != nil{
                completion(false, "There is some error in authorization")
            }else{
                completion(success, nil)
            }
        }
    }
    
    //MARK: - Read heart rate
    
    func fetchLatestHeartRateSample(
       completion: @escaping (_ samples: [HKQuantitySample]?) -> Void) {

       /// Create sample type for the heart rate
       guard let sampleType = HKObjectType
         .quantityType(forIdentifier: .heartRate) else {
           completion(nil)
         return
       }

       /// Predicate for specifiying start and end dates for the query
       let predicate = HKQuery
         .predicateForSamples(
           withStart: Date.distantPast,
           end: Date(),
           options: .strictEndDate)

       /// Set sorting by date.
       let sortDescriptor = NSSortDescriptor(
         key: HKSampleSortIdentifierStartDate,
         ascending: false)

       /// Create the query
       let query = HKSampleQuery(
         sampleType: sampleType,
         predicate: predicate,
         limit: Int(HKObjectQueryNoLimit),
         sortDescriptors: [sortDescriptor]) { (_, results, error) in

           guard error == nil else {
             print("Error: \(error!.localizedDescription)")
             return
           }
           completion(results as? [HKQuantitySample])
       }
       healthStore.execute(query)
     }
    
    
    func getTodaysSteps(completion: @escaping (Double) -> Void) {
        let stepsQuantityType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
        
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(
            withStart: startOfDay,
            end: now,
            options: .strictStartDate
        )
        
        let query = HKStatisticsQuery(
            quantityType: stepsQuantityType,
            quantitySamplePredicate: predicate,
            options: .cumulativeSum
        ) { _, result, _ in
            guard let result = result, let sum = result.sumQuantity() else {
                completion(0.0)
                return
            }
            completion(sum.doubleValue(for: HKUnit.count()))
        }
        
        healthStore.execute(query)
    }
    
    func getWeeklyEnergyBurned(completion: @escaping((HKStatisticsCollection?)->())){
        let calendar = Calendar.current
        // Create a 1-week interval.
        let interval = DateComponents(day: 1)
        // Set the anchor for 3 a.m. on Monday.
        let components = DateComponents(calendar: calendar,
                                        timeZone: calendar.timeZone,
                                        hour: 0,
                                        minute: 0,
                                        second: 0,
                                        weekday: 2)
        guard let anchorDate = calendar.nextDate(after: Date(),
                                                 matching: components,
                                                 matchingPolicy: .nextTime,
                                                 repeatedTimePolicy: .first,
                                                 direction: .backward) else {
            completion(nil)
            fatalError("*** unable to find the previous Monday. ***")
        }
        guard let quantityType = HKObjectType.quantityType(forIdentifier: .activeEnergyBurned) else {
            completion(nil)
            fatalError("*** Unable to create a step count type ***")
        }
        
        let query = HKStatisticsCollectionQuery(quantityType: quantityType,
                                                quantitySamplePredicate: nil,
                                                options: .cumulativeSum,
                                                anchorDate: anchorDate,
                                                intervalComponents: interval)
        query.initialResultsHandler = {
            query, results, error in
            
            // Handle errors here.
            if let error = error as? HKError {
                completion(nil)
                switch (error.code) {
                case .errorDatabaseInaccessible:
                    // HealthKit couldn't access the database because the device is locked.
                    return
                default:
                    // Handle other HealthKit errors here.
                    return
                }
            }
            
            guard let statsCollection = results else {
                // You should only hit this case if you have an unhandled error. Check for bugs
                // in your code that creates the query, or explicitly handle the error.
               completion(nil)
                return
            }
            completion(statsCollection)
        }
        
        healthStore.execute(query)
    }
    
    
    
    func retrieveSleepAnalysis(completion: @escaping ([HKSample]?) -> Void) {
        if let sleepType = HKObjectType.categoryType(forIdentifier: .sleepAnalysis) {
            
            // Use a sortDescriptor to get the recent data first
            let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
            
            let predicate = HKQuery.predicateForSamples(
                withStart: Date.distantPast,
                end: Date(),
                options: .strictEndDate
            )
            // we create our query with a block completion to execute
            let query = HKSampleQuery(sampleType: sleepType, predicate: predicate, limit: Int(HKObjectQueryNoLimit), sortDescriptors: [sortDescriptor]) { (query, tmpResult, error) -> Void in
                
                if error != nil {
                    
                    completion(nil)
                    return
                    
                }
                
                if let result = tmpResult {
                    completion(result)
                }
            }
            
            // finally, we execute our query
            healthStore.execute(query)
        }else{
            completion(nil)
        }
    }
    
}
