//
//  StandardFeatures.swift
//  Allwise2
//
//  Created by Arthur GUERIN on 15/04/2024.
//

import Foundation
import AVFoundation
import CoreHaptics


/// BACKGROUND SOUND

// Audio player variable
var audioPlayer: AVAudioPlayer?

// Function to start playing music
func startPlayingMusic() {
    let randomNumber = Int.random(in: 0...4) // Random number between 0 and 4
    let fileName = "chill_\(randomNumber)" // Construct file name using the random number
    guard let url = Bundle.main.url(forResource: fileName, withExtension: "mp3") else { return }
    do {
        audioPlayer = try AVAudioPlayer(contentsOf: url)
        audioPlayer?.numberOfLoops = -1 // Loop indefinitely
        audioPlayer?.play()
    } catch let error {
        print("Error playing music: \(error.localizedDescription)")
    }
}

// Function to stop playing music
func stopPlayingMusic() {
    audioPlayer?.stop()
    audioPlayer = nil
}


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
