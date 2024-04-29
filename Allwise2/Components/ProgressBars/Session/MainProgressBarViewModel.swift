//
//  MainProgressBar.swift
//  Allwise2
//
//  Created by Hugo Peyron on 24/04/2024.
//

import Foundation
import SwiftUI
import Combine

class SessionProgressBarViewModel: ObservableObject {
    let tasks = ["Breathe", "Meditate", "Manifest", "Journal", "Reflect"]
    let icons = ["circle.circle", "figure.mind.and.body", "figure.mixed.cardio", "text.book.closed.fill", "quote.bubble" ]
    private let incrementDuration = 6.0 // seconds for simplicity, adjust as needed
    
    @Published var progressValue: CGFloat = 0.0
    
    func incrementProgress() {
        let nextIndex = Int(progressValue * CGFloat(tasks.count)) + 1
        if nextIndex <= tasks.count {
            let nextProgress = CGFloat(nextIndex) / CGFloat(tasks.count)
            withAnimation(.linear(duration: incrementDuration)) {
                progressValue = nextProgress
                print("progress \(nextIndex.description)")
            }
        }
    }
    
    func isTaskCompleted(index: Int) -> Bool {
        // Determine if the task at the given index is completed based on the current progress
        return CGFloat(index + 1) / CGFloat(tasks.count) <= progressValue
    }
    
    func reset() {
        progressValue = 0
    }
}
