//
//  SubTopicViewModel.swift
//  Allwise2
//
//  Created by Hugo Peyron on 11/11/2023.
//

import Foundation
import SwiftUI

class SubTopicViewModel : ObservableObject {
     
    @Published var subTopic: SubTopic
    @Published var questionViewResult : Bool? // Get the result from the question view.
    @Published var selectedTab : Int = 0 // To manage the tabView navigation. Is incremented after each answer
    @Published var subTopicProgress: Float = 0 // Number of validated question / questions.count + errors.count
    @Published var triggerQuitAlert: Bool = false // To quite the subTopics View. Will erase any progress.
    @Published var triggerResultView : Bool = false
    @Published var triggerErrorsView : Bool = false
    
    var answeredQuestionsCount = 0
    
    // Handle the nav from one question to the other
    @Published var currentQuestionIndex: Int = 0
    
    var currentQuestion: Question {
        pendingQuestions[currentQuestionIndex]
    }
    
    var pendingQuestions: [Question] // Questions yet to be answered
    var errorQuestions: [Question] = [] // Questions answered incorrectly
    
    init(subTopic: SubTopic) {
        self.subTopic = subTopic
        self.pendingQuestions = subTopic.questions
    }
    
    func moveToNextQuestion() {
        updateProgress()
        
        if currentQuestionIndex < pendingQuestions.count - 1 {
            currentQuestionIndex += 1
        } else {
            // All questions have been attempted once
            if !errorQuestions.isEmpty {
                // Start over with the incorrectly answered questions
                triggerErrorsView = true
                pendingQuestions = errorQuestions
                errorQuestions.removeAll()
                currentQuestionIndex = 0
            } else {
                // All questions answered correctly, trigger result view
                triggerResultView = true
            }
        }
    }

    func checkResult(for question: Question) {
                        
        if questionViewResult == true {
            // Answer is correct, proceed normally
            answeredQuestionsCount += 1
        } else {
            // Answer is incorrect, add this question to errorQuestions
            if !errorQuestions.contains(where: { $0.id == question.id }) {
                errorQuestions.append(question)
            }
        }
    }

    private func updateProgress() {
        let totalQuestions = subTopic.questions.count
        subTopicProgress = totalQuestions > 0 ? Float(answeredQuestionsCount) / Float(totalQuestions) : 0
    }
}

