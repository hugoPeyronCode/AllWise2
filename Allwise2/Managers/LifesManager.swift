//
//  LifesManager.swift
//  Allwise2
//
//  Created by Hugo Peyron on 16/11/2023.
//

import Foundation

class LifesManager : ObservableObject {
    
    static let shared = LifesManager()
    
    @Published var lifesCount = 0
    @Published var triggerModal : Bool = false
    
    var hasEnoughLifes : Bool { lifesCount > 0 }
    
    func loseAlife() {
        if hasEnoughLifes {
            lifesCount -= 1
            print("Life Manager removed a life")
        }
    }
    
    func refillLifes(count: Int) {
        print("Added \(count) lifes to the user")
        lifesCount += count
    }
}
