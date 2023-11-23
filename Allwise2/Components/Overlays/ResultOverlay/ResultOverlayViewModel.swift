//
//  ResultOverlayViewModel.swift
//  Allwise2
//
//  Created by Hugo Peyron on 21/11/2023.
//

import Foundation
import SwiftUI

class ResultOverlayViewModel : ObservableObject {
    
    @Published var message : String = "Not yet initialised"
    @Published var explanation : String = "No explanation yet"
    @Published var icon : String = "xmark"
    @Published var fontColor : Color = Color.duoGreen
    @Published var color : Color = .paleGreen
    
    @Published var validationButtonContent : String = ""
    @Published var validationButtonColor : Color = .duoGreen
    
    var congratulationsMessages = ["Nicely done!", "Congrats!", "Nice one!", "Bravo!", "Super!", "Good one!", "Right!", "Correct!"]
    
    func updateContent(questionExplanation: String, questionState: QuestionState) {
        switch questionState {
        case .isSelected:
            message = ""
        case .isValid:
            message = congratulationsMessages.randomElement() ?? "Congrats"
            explanation = questionExplanation
            icon = "checkmark.circle.fill"
            fontColor = .duoGreen
            color = .paleGreen
        case .isWrong:
            message = "Incorrect"
            explanation = questionExplanation
            fontColor = .duoRed
            icon = "xmark.circle.fill"
            color = .paleRed
        case .isNeutral:
            message = ""
        }
    }
    
}
