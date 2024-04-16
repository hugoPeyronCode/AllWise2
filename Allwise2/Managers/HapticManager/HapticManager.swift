//
//  HapticManager.swift
//  Allwise2
//
//  Created by Hugo Peyron on 16/04/2024.
//

import Foundation
import CoreHaptics

/// HAPTIC SYSTEM

// Haptic variable
var hapticEngine: CHHapticEngine?

// Call this once, on onAppear or init
func prepareHaptics() {
    do {
        hapticEngine = try CHHapticEngine()
        try hapticEngine?.start()
    } catch {
        print("There was an error creating the haptic engine: \(error.localizedDescription)")
    }
}

// Updated function to play a custom haptic feedback
func playHaptic(intensity: Float, sharpness: Float) {
    guard let engine = hapticEngine else { return }

    // Parameters for the haptic event
    let intensityParameter = CHHapticEventParameter(parameterID: .hapticIntensity, value: intensity)
    let sharpnessParameter = CHHapticEventParameter(parameterID: .hapticSharpness, value: sharpness)
    let event = CHHapticEvent(eventType: .hapticContinuous, parameters: [intensityParameter, sharpnessParameter], relativeTime: 0, duration: 1)

    do {
        let pattern = try CHHapticPattern(events: [event], parameters: [])
        let player = try engine.makePlayer(with: pattern)
        try player.start(atTime: 0) // Start immediately
    } catch {
        print("Failed to play custom haptic: \(error.localizedDescription)")
    }
}
