//
//  MatchTheTilesView.swift
//  Allwise2
//
//  Created by Hugo Peyron on 22/11/2023.
//

import SwiftUI

class MatchingViewModel: ObservableObject {
    
    var matchingQuestion: MatchingQuestion
    
    @Published var shuffledQuestions: [QuestionAnswerPair]
    @Published var shuffledAnswers: [QuestionAnswerPair]

    init(matchingQuestion: MatchingQuestion) {
        self.matchingQuestion = matchingQuestion
        self.shuffledQuestions = matchingQuestion.questions.shuffled()
        self.shuffledAnswers = matchingQuestion.questions.shuffled()
    }
    
    @Published var selectedQuestionID: UUID?
    @Published var selectedAnswerID: UUID?
    
    @Published var gameState : QuestionState = .isNeutral
    @Published var showResultOverlay : Bool = false

    
    func selectQuestion(_ id: UUID) {
        guard let questionIndex = matchingQuestion.questions.firstIndex(where: { $0.id == id }),
              matchingQuestion.questions[questionIndex].questionState != .isValid else { return }
        
        selectedQuestionID = id
        updateSelectionStates(for: id, type: .question)
    }
    
    func selectAnswer(_ id: UUID) {
        guard let answerIndex = matchingQuestion.questions.firstIndex(where: { $0.id == id }),
              matchingQuestion.questions[answerIndex].answerState != .isValid else { return }
        
        selectedAnswerID = id
        updateSelectionStates(for: id, type: .answer)
    }
    
    private func updateSelectionStates(for id: UUID, type: SelectionType) {
        // Reset all non-validated items to isNeutral in the original array
        for index in matchingQuestion.questions.indices {
            if matchingQuestion.questions[index].questionState != .isValid && type == .question {
                matchingQuestion.questions[index].questionState = .isNeutral
            }
            if matchingQuestion.questions[index].answerState != .isValid && type == .answer {
                matchingQuestion.questions[index].answerState = .isNeutral
            }
        }

        // Reset all non-validated items to isNeutral in the shuffled arrays
        if type == .question {
            for index in shuffledQuestions.indices {
                if shuffledQuestions[index].questionState != .isValid {
                    shuffledQuestions[index].questionState = .isNeutral
                }
            }
            if let selectedIndex = shuffledQuestions.firstIndex(where: { $0.id == id }) {
                shuffledQuestions[selectedIndex].questionState = .isSelected
            }
        }

        if type == .answer {
            for index in shuffledAnswers.indices {
                if shuffledAnswers[index].answerState != .isValid {
                    shuffledAnswers[index].answerState = .isNeutral
                }
            }
            if let selectedIndex = shuffledAnswers.firstIndex(where: { $0.id == id }) {
                shuffledAnswers[selectedIndex].answerState = .isSelected
            }
        }
    }

    
    func checkMatch() {
         if let qID = selectedQuestionID, let aID = selectedAnswerID,
            let questionIndex = shuffledQuestions.firstIndex(where: { $0.id == qID }),
            let answerIndex = shuffledAnswers.firstIndex(where: { $0.id == aID }) {
            
            let selectedQuestion = shuffledQuestions[questionIndex]
            let selectedAnswer = shuffledAnswers[answerIndex]

            // Find the original pair in the unshuffled array
            if let originalPairIndex = matchingQuestion.questions.firstIndex(where: { $0.question == selectedQuestion.question && $0.answer == selectedAnswer.answer }) {
                matchingQuestion.questions[originalPairIndex].questionState = .isValid
                matchingQuestion.questions[originalPairIndex].answerState = .isValid

                // Update shuffled arrays to reflect the new state
                shuffledQuestions[questionIndex].questionState = .isValid
                shuffledAnswers[answerIndex].answerState = .isValid
            } else {
                withAnimation {
                    shuffledQuestions[questionIndex].questionState = .isWrong
                    shuffledAnswers[answerIndex].answerState = .isWrong
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.shuffledQuestions[questionIndex].questionState = .isNeutral
                        self.shuffledAnswers[answerIndex].answerState = .isNeutral
                    }
                }
            }

            selectedQuestionID = nil
            selectedAnswerID = nil
         }
         
         allPairsValidated()
     }
    
    func allPairsValidated() {
        if matchingQuestion.questions.allSatisfy({ $0.questionState == .isValid && $0.answerState == .isValid }) {
            gameState = .isValid
        }
    }
    
    func resetGame() {
        matchingQuestion.questions.indices.forEach { index in
            matchingQuestion.questions[index].questionState = .isNeutral
            matchingQuestion.questions[index].answerState = .isNeutral
        }
        selectedQuestionID = nil
        selectedAnswerID = nil
    }
    
    private func resetSelections(except id: UUID, for type: SelectionType) {
        matchingQuestion.questions.indices.forEach { index in
            if matchingQuestion.questions[index].id != id {
                if type == .question {
                    matchingQuestion.questions[index].questionState = .isNeutral
                } else {
                    matchingQuestion.questions[index].answerState = .isNeutral
                }
            }
        }
    }
    
    enum SelectionType {
        case question, answer
    }
}
