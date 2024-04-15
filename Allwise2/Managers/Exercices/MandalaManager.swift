//
//  MandalaManager.swift
//  Allwise2
//
//  Created by Arthur GUERIN on 15/04/2024.
//

import Foundation
import AVFAudio

class ExerciseTimer {
    var bellPlayer: AVAudioPlayer?
    var bellTimer: Timer?
    var exerciseTime: TimeInterval = 0
    var startTime: Date?
    var totalBellsPlayed = 0
    var onProgressUpdate: ((Double) -> Void)?
    var onBellRing: (() -> Void)?
    
    // Function to start the whole exercise
    func startExercise() {
        exerciseTime = Double(Int.random(in: 6...10) * 5) // Random exercise time between 30 and 50 seconds, in 5-second increments
        startTime = Date()
        scheduleNextBellSound()
    }
    
    // Function to schedule the next bell sound within the exercise time
    func scheduleNextBellSound() {
        guard let startTime = startTime else { return }
        
        let endTime = startTime.addingTimeInterval(exerciseTime)
        if Date() < endTime {
            let interval = Double.random(in: 8...10)
            bellTimer = Timer.scheduledTimer(withTimeInterval: interval, repeats: false) { [weak self] _ in
                self?.playBellSound()
                self?.totalBellsPlayed += 1
                self?.scheduleNextBellSound() // Schedule the next bell sound
            }
        } else {
            // Exercise time has finished
            stopBellTimer()
        }
    }
    
    // Function to play bell sound
    func playBellSound() {
        guard let url = Bundle.main.url(forResource: "bellsound", withExtension: "mp3") else { return }
        do {
            bellPlayer = try AVAudioPlayer(contentsOf: url)
            bellPlayer?.play()
            onBellRing?()
        } catch let error {
            print("Error playing bell sound: \(error.localizedDescription)")
        }
    }
    
    // Function to stop the bell timer and any ongoing bell sound
    func stopBellTimer() {
        bellTimer?.invalidate()
        bellTimer = nil
        bellPlayer?.stop()
        bellPlayer = nil
    }
    
    // Call this function when the view disappears to ensure that no more bell sounds are scheduled
    func viewDidDisappear() {
        stopBellTimer()
    }
    
    // Calculate progress
    func updateProgress() {
        guard let startTime = startTime else { return }
        let currentTime = Date()
        let elapsedTime = currentTime.timeIntervalSince(startTime)
        let progress = elapsedTime / exerciseTime
        onProgressUpdate?(progress) 
        // Call the callback with the current progress
    }
}
