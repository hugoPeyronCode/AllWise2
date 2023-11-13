//
//  QuestionViewModel.swift
//  Allwise2
//
//  Created by Hugo Peyron on 11/11/2023.
//

import Foundation

class QuestionViewModel : ObservableObject {
    
    @Published var questionState : QuestionState = .isNeutral
    @Published var selectedAnswers : [Answer] = []
    @Published var isMoveToNextPageButtonAppears: Bool = false
    
    
    func isAnswersArrayContainsSomething(for answersArray: [Answer]) -> Bool {
        return !answersArray.isEmpty
    }
    
}
