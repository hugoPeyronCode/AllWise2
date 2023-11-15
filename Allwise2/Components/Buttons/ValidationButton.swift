//
//  ValidationButton.swift
//  Allwise2
//
//  Created by Hugo Peyron on 14/11/2023.
//

import SwiftUI

struct ValidationButton : View {
    
    var questionState: QuestionState
    var action : () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(content())
                .frame(maxWidth: .infinity, maxHeight: 50)
                .foregroundStyle(questionState != .isNeutral ? .white : .gray)
                .font(.title2)
                .bold()
                .fontDesign(.rounded)
                .background(backgroundColor())
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .padding()
        }
        .disabled(questionState == .isNeutral)
    }
    
    func content() -> String {
        switch questionState {
        case .isSelected:
            return "Check"
        case .isValid:
            return "Continue"
        case .isWrong:
            return "Got it"
        case .isNeutral:
            return "Select"
        }
    }
    
    func backgroundColor() -> Color {
        switch questionState {
        case .isSelected:
            return .blue
        case .isValid:
            return .duoGreen
        case .isWrong:
            return .duoRed
        case .isNeutral:
            return .paleGray
        }
    }
}

#Preview {
    ValidationButton(questionState: .isWrong, action: {})
}
