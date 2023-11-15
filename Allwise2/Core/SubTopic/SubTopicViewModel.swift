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
    
    @Published var subtopicViewState : SubTopicViewState = .triggerQuestionView
     
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
                }
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

