//
//  Permission.swift
//  health-quest
//
//  Created by Adam Golczak on 29/10/2017.
//  Copyright © 2017 PxlBorn. All rights reserved.
//

import Foundation
import HealthKit

class Permission {
    var fatPrecentage = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyFatPercentage)!
    var bodyMass = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMass)!
    var leanBodyMass = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.leanBodyMass)!
    var energy = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.activeEnergyBurned)!
}
