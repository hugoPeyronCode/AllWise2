//
//  ResultOverlayManager.swift
//  Allwise2
//
//  Created by Hugo Peyron on 20/11/2023.
//

import Foundation
import SwiftUI

class ResultOverlayManager : ObservableObject {
    
    @Published var questionState : QuestionState = .isNeutral
    
    @Published var showResultOverlay : Bool = false
    
    
    // DYNAMIC UI OF OVERLAY
    @Published var resultOverMessage : String = ""
    @Published var resultOverlayIcon : String = ""
    @Published var resultOverlayFontColor : Color = Color.duoGreen
    @Published var resultOverlayColor : Color = .green
    @Published var resultOverHeight : CGFloat = 0
    
    @Published var validationButtonContent : String = ""
    @Published var validationButtonColor : Color = .duoGreen
    
    //
    func isAnswersArrayContainsSomething(for answersArray: [Answer]) -> Bool {
        return !answersArray.isEmpty
    }
    
    var congratulationsMessages = ["Nicely done!", "Congrats!", "Nice one!", "Bravo!", "Super!", "Good one!", "Right!", "Correct!"]
    
    // LOGIC
    func updateResultOverlay() {
        
        print("update result overlay")
                
        switch questionState {
        case .isSelected:
            showResultOverlay = false
        case .isValid:
            resultOverMessage = congratulationsMessages.randomElement() ?? "Correct!"
            resultOverlayIcon = "checkmark.circle.fill"
            resultOverlayFontColor = .duoGreen
            resultOverlayColor = .paleGreen
            resultOverHeight = 200
        case .isWrong:
            resultOverMessage = "Incorrect"
            resultOverlayIcon = "xmark.circle.fill"
            resultOverlayFontColor = .duoRed
            resultOverlayColor = .paleRed
            resultOverHeight = 270
        case .isNeutral:
            showResultOverlay = false
        }
    }
    
}
