//
//  QuestionViewModel.swift
//  Allwise2
//
//  Created by Hugo Peyron on 11/11/2023.
//

import Foundation
import SwiftUI

enum QuestionState {
    case isSelected, isValid, isWrong, isNeutral
}

class QuestionViewModel : ObservableObject {
    
    @Published var questionState : QuestionState = .isNeutral
    @Published var selectedAnswers : [Answer] = []
    @Published var showResultOverlay : Bool = false
    
    func toggleResultOverlay() {
        switch questionState {
        case .isSelected, .isNeutral:
            showResultOverlay = false
        case .isValid, .isWrong:
            showResultOverlay = true
        }
    }
}
