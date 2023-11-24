//
//  SubTopicViewModel.swift
//  Allwise2
//
//  Created by Hugo Peyron on 11/11/2023.
//

import Foundation
import SwiftUI

enum SubTopicViewState {
    case triggerErrorView
    case triggerResultView
    case triggerQuestionView
}

class SubTopicViewModel : ObservableObject {
    
    @ObservedObject var lifesManager = LifesManager.shared
    
    @Published var subtopicViewState : SubTopicViewState = .triggerQuestionView
    @Published var subTopic: SubTopic
    @Published var questionViewResult : Bool? // Get the result from the question view.
    @Published var selectedTab : Int = 0 // To manage the tabView navigation. Is incremented after each answer
    @Published var subTopicProgress: Float = 0 // Number of validated question / questions.count + errors.count
    @Published var triggerQuitAlert: Bool = false // To quite the subTopics View. Will erase any progress.

    var answeredQuestionsCount = 0
    
    // Handle the nav from one question to the other
    @Published var currentQuestionIndex: Int = 0
    
    var currentQuestion: any Question {
        pendingQuestions[currentQuestionIndex]
    }
    
    var pendingQuestions: [any Question] // Questions yet to be answered
    var errorQuestions: [any Question] = [] // Questions answered incorrectly
    
    
    // STATS FOR THE RESULT VIEW
    // Accuracy
    @Published var correctAnswersCount = 0
    @Published var incorrectAnswersCount = 0
    var accuracy: Double {
        let totalAnswered = correctAnswersCount + incorrectAnswersCount
        return totalAnswered > 0 ? Double(correctAnswersCount) / Double(totalAnswered) : 1.0
    }
    
    // Speed
    private var sessionStartTime: Date?
    private var sessionEndTime: Date?
    
    @Published var duration : Int = 0
    
    // Computed property to get the session duration in seconds
    var sessionDuration: Int {
        guard let start = sessionStartTime, let end = sessionEndTime else { return 0 }
        return Int(end.timeIntervalSince(start))
    }
    
    // XP
    var xp: Int {
        incorrectAnswersCount == 0 ? 20 : 15
    }
    
    // INIT
    init(subTopic: SubTopic) {
        self.subTopic = subTopic
        self.pendingQuestions = subTopic.questions
    }
    
    // FUNCTIONS
    
    func moveToNextQuestion() {
        updateProgress()
        
        if currentQuestionIndex < pendingQuestions.count - 1 {
            // Move to the next question in the pendingQuestions array
            withAnimation(.bouncy){
                currentQuestionIndex += 1
            }
        } else {
            // Finished the current batch of questions
            if !errorQuestions.isEmpty {
                // There are error questions to display
                withAnimation(.snappy) {
                    subtopicViewState = .triggerErrorView
                    pendingQuestions = errorQuestions
                    errorQuestions.removeAll()
                    currentQuestionIndex = 0
                }
            } else {
                // No error questions, all questions answered correctly
                withAnimation(.snappy) {
                    subtopicViewState = .triggerResultView
                    endSession()
                    duration = sessionDuration
                }
            }
        }
    }
    
    
    func checkResult(for question: any Question) {
        if questionViewResult == true {
            // Answer is correct, proceed normally
            answeredQuestionsCount += 1
            correctAnswersCount += 1
        } else {
            if lifesManager.hasEnoughLifes {
                lifesManager.loseAlife()
                incorrectAnswersCount += 1
                // Answer is incorrect, add this question to errorQuestions
                if !errorQuestions.contains(where: { $0.id == question.id }) {
                    errorQuestions.append(question)
                }
            } else {
                lifesManager.triggerModal.toggle()
            }
        }
        
        updateProgress()
        
    }
    
    private func updateProgress() {
        let totalQuestions = subTopic.questions.count
        subTopicProgress = totalQuestions > 0 ? Float(answeredQuestionsCount) / Float(totalQuestions) : 0
    }
    
    
    // Time TRACKING FUCNTIONS
    // Start the timer when the subtopic session starts
    func startSession() {
        sessionStartTime = Date()
    }
    
    // Call this when the subtopic session ends
    func endSession() {
        sessionEndTime = Date()
    }
    
    
}
