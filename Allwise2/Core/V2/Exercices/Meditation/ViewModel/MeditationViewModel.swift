//
//  MeditationViewModel.swift
//  Allwise2
//
//  Created by Hugo Peyron on 25/04/2024.
//

import Foundation
import Combine

class MeditationViewModel: ObservableObject {
    // Expose the time and progress for the view to bind to
    @Published var exerciceTime: Int = 60
    @Published var progress: Float = 0
    
    private var totalTime: Int = 30 // Total time for the exercise
    private var timer: AnyCancellable?

    // Function to start the timer
    func startTimer() {
        // Reset the timer
        exerciceTime = totalTime
        progress = 1.0
        
        timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect().sink { [weak self] _ in
            guard let self = self else { return }
            if self.exerciceTime > 0 {
                self.exerciceTime -= 1
                self.progress = Float(self.exerciceTime) / Float(self.totalTime)
            } else {
                self.timer?.cancel()
            }
        }
    }

    // Function to stop the timer
    func stopTimer() {
        timer?.cancel()
        timer = nil
    }
    
    // Call this function when the view disappears to clean up
    deinit {
        stopTimer()
    }
}
