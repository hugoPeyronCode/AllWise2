//
//  MatchTheTilesView.swift
//  Allwise2
//
//  Created by Hugo Peyron on 22/11/2023.
//

import SwiftUI

// Structure for question-answer pairs
struct QuestionAnswerPair: Identifiable {
    let id = UUID()
    var question: String
    var answer: String
    var questionState: QuestionState = .isNeutral
    var answerState: QuestionState = .isNeutral
}

class MatchingViewModel: ObservableObject {
    @Published var pairs: [QuestionAnswerPair] = [
        QuestionAnswerPair(question: "Paris", answer: "France"),
        QuestionAnswerPair(question: "London", answer: "UK"),
        QuestionAnswerPair(question: "Berlin", answer: "Germany")
    ]
    
    @Published var selectedQuestionID: UUID?
    @Published var selectedAnswerID: UUID?
    
    @Published var gameState : QuestionState = .isNeutral
    
    func selectQuestion(_ id: UUID) {
        guard let questionIndex = pairs.firstIndex(where: { $0.id == id }),
              pairs[questionIndex].questionState != .isValid else { return }
        
        selectedQuestionID = id
        updateSelectionStates(for: id, type: .question)
    }
    
    func selectAnswer(_ id: UUID) {
        guard let answerIndex = pairs.firstIndex(where: { $0.id == id }),
              pairs[answerIndex].answerState != .isValid else { return }
        
        selectedAnswerID = id
        updateSelectionStates(for: id, type: .answer)
    }
    
    private func updateSelectionStates(for id: UUID, type: SelectionType) {
        for index in pairs.indices {
            if pairs[index].id != id {
                if type == .question && pairs[index].questionState != .isValid {
                    pairs[index].questionState = .isNeutral
                } else if type == .answer && pairs[index].answerState != .isValid {
                    pairs[index].answerState = .isNeutral
                }
            } else {
                if type == .question {
                    pairs[index].questionState = .isSelected
                } else if type == .answer {
                    pairs[index].answerState = .isSelected
                }
            }
        }
    }
    
    func checkMatch() {
        if let qID = selectedQuestionID, let aID = selectedAnswerID,
           let questionIndex = pairs.firstIndex(where: { $0.id == qID }),
           let answerIndex = pairs.firstIndex(where: { $0.id == aID }) {
            
            // Correcting the logic: Check if the selected question's answer matches the selected answer's answer
            if pairs[questionIndex].answer == pairs[answerIndex].answer {
                pairs[questionIndex].questionState = .isValid
                pairs[answerIndex].answerState = .isValid
            } else {
                withAnimation {
                    pairs[questionIndex].questionState = .isWrong
                    pairs[answerIndex].answerState = .isWrong
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.pairs[questionIndex].questionState = .isNeutral
                        self.pairs[answerIndex].answerState = .isNeutral
                    }
                }
            }
            selectedQuestionID = nil
            selectedAnswerID = nil
        }
        
        allPairsValidated()
    }
    
    func allPairsValidated() {
        if pairs.allSatisfy({ $0.questionState == .isValid && $0.answerState == .isValid }) {
            gameState = .isValid
        }
    }
    
    func resetGame() {
        pairs.indices.forEach { index in
            pairs[index].questionState = .isNeutral
            pairs[index].answerState = .isNeutral
        }
        selectedQuestionID = nil
        selectedAnswerID = nil
    }
    
    private func resetSelections(except id: UUID, for type: SelectionType) {
        pairs.indices.forEach { index in
            if pairs[index].id != id {
                if type == .question {
                    pairs[index].questionState = .isNeutral
                } else {
                    pairs[index].answerState = .isNeutral
                }
            }
        }
    }
    
    enum SelectionType {
        case question, answer
    }
}
