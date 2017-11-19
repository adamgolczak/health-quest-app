//
//  HealthStore.swift
//  health-quest
//
//  Created by Adam Golczak on 22/10/2017.
//  Copyright © 2017 PxlBorn. All rights reserved.
//

import Foundation
import HealthKit

class HealthStore {
    let healthStore = HKHealthStore()
    
    var fat = 0.0
    var bodyMass = 0.0
    var bodyLeanMass = 0.0
    var energy = 0.0
    
    func authorizeHealthKit() -> Bool {
        var isEnabled = true
        
        if HKHealthStore.isHealthDataAvailable() {
            let permissions = Permission()
            
            // Requesting permissions to display data from Apple Health
            var readTypes = Set<HKObjectType>()
            readTypes.insert(permissions.fatPrecentage)
            readTypes.insert(permissions.bodyMass)
            readTypes.insert(permissions.leanBodyMass)
            readTypes.insert(permissions.energy)
            
            healthStore.requestAuthorization(toShare: nil, read: readTypes, completion: { (success, err) in
               isEnabled = success
            })
            
        } else {
            isEnabled = false
        }
        
        return isEnabled
    }
    
    func getFatMass() {
        
        // Fetching body fat precentage
        let fatCount = HKQuantityType.quantityType(
            forIdentifier: HKQuantityTypeIdentifier.bodyFatPercentage)
        
        let fatQuery = HKSampleQuery(sampleType: fatCount!, predicate: nil, limit: 100, sortDescriptors: nil) { (query, results, err) in
            if let results = results as? [HKQuantitySample] {
                
                let fetchedFat = ((results.last?.quantity.doubleValue(for: HKUnit.percent()))! * 100)
                DISPLAY_LOGS ? print("You have \(fetchedFat)% of body fat") : nil
                self.fat = fetchedFat
            }
        }
        healthStore.execute(fatQuery)
    }
    
    func getMass() {
        
        // Fetching body weight
        let bodyMass = HKQuantityType.quantityType(
            forIdentifier: HKQuantityTypeIdentifier.bodyMass)
        
        let bodyMassQuery = HKSampleQuery(sampleType: bodyMass!, predicate: nil, limit: 100, sortDescriptors: nil) { (query, results, err) in
            if let results = results as? [HKQuantitySample] {
                
                let fetchedMass = (results.last?.quantity.doubleValue(for: HKUnit.gram()))!
                DISPLAY_LOGS ? print("You have \(String(format: "%.1f", (fetchedMass / 1000)))kg of body mass") : nil
                self.bodyMass = fetchedMass
            }
        }
        healthStore.execute(bodyMassQuery)
    }
    
    func getLeanMass() {
        
        // Fetching lean body mass
        let bodyLeanMass = HKQuantityType.quantityType(
            forIdentifier: HKQuantityTypeIdentifier.leanBodyMass)
        
        let bodyLeanMassQuery = HKSampleQuery(sampleType: bodyLeanMass!, predicate: nil, limit: 100, sortDescriptors: nil) { (query, results, err) in
            if let results = results as? [HKQuantitySample] {
                
                let fetchedLeanMass = (results.last?.quantity.doubleValue(for: HKUnit.gram()))!
                DISPLAY_LOGS ? print("You have \(String(format: "%.1f", (fetchedLeanMass / 1000)))kg of lean body mass") : nil
                self.bodyLeanMass = fetchedLeanMass
            }
        }
        healthStore.execute(bodyLeanMassQuery)
    }
    
    func getEnergy() {
        
        // Fetching calories bourned
        let energy = HKQuantityType.quantityType(
            forIdentifier: HKQuantityTypeIdentifier.activeEnergyBurned)
        
        let energyQuery = HKSampleQuery(sampleType: energy!, predicate: nil, limit: 100, sortDescriptors: nil) { (query, results, err) in
            if let results = results as? [HKQuantitySample] {
                
                let fetchedEnergy = (results.last?.quantity.doubleValue(for: HKUnit.kilocalorie()))!
                DISPLAY_LOGS ? print("You have bourned \(String(format: "%.0f", fetchedEnergy))kcal of energy") : nil
                self.energy = fetchedEnergy
            }
        }
        healthStore.execute(energyQuery)
    }
}
