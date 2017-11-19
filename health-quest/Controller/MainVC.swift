//
//  MainVC.swift
//  health-quest
//
//  Created by Adam Golczak on 22/10/2017.
//  Copyright © 2017 PxlBorn. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    
    @IBOutlet weak var precentageLbl: UILabel!
    @IBOutlet weak var precentageUnitLbl: UILabel!
    @IBOutlet weak var leanMassLbl: UILabel!
    @IBOutlet weak var leanMassUnitLbl: UILabel!
    @IBOutlet weak var bodyMassLbl: UILabel!
    @IBOutlet weak var bodyMassUnitLbl: UILabel!
    @IBOutlet weak var energyLbl: UILabel!
    @IBOutlet weak var energyUnitLbl: UILabel!
    @IBOutlet var cardViews: [UIView]!
    
    let healthStore = HealthStore()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        DISPLAY_LOGS ? print("Authorized: \(healthStore.authorizeHealthKit())") : nil
        
        // Make every view cornerRadius = 7.0
        for card in cardViews {
            card.layer.cornerRadius = 7.0
        }
    }
    
    override func viewDidLoad() {
        if healthStore.authorizeHealthKit() {
            
            // Fetch heathStore methods
            healthStore.getFatMass()
            healthStore.getLeanMass()
            healthStore.getMass()
            healthStore.getEnergy()
            
            DispatchQueue.main.async {
                // Handle no data
                if self.healthStore.fat != 0.0 {
                    self.precentageLbl.text = "\(String(self.healthStore.fat))"
                } else {
                    self.precentageLbl.text = "no"
                    self.precentageUnitLbl.text = "data"
                }
                
                // Handle no data
                if self.healthStore.bodyLeanMass != 0.0 {
                    self.leanMassLbl.text = "\(String(format: "%.1f", (self.healthStore.bodyLeanMass / 1000)))"
                } else {
                    self.leanMassLbl.text = "no"
                    self.leanMassUnitLbl.text = "data"
                }
                
                // Handle no data
                if self.healthStore.bodyLeanMass != 0.0 {
                    self.bodyMassLbl.text = "\(String(format: "%.1f", (self.healthStore.bodyMass / 1000)))"
                } else {
                    self.bodyMassLbl.text = "no"
                    self.bodyMassUnitLbl.text = "data"
                }
                
                // Handle no data
                if self.healthStore.bodyLeanMass != 0.0 {
                    self.energyLbl.text = "\(String(format: "%.0f", self.healthStore.energy))"
                } else {
                    self.energyLbl.text = "no"
                    self.energyUnitLbl.text = "data"
                }
                
            }
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

}

