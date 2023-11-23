//
//  MatchingButton.swift
//  Allwise2
//
//  Created by Hugo Peyron on 23/11/2023.
//

import SwiftUI

struct MatchingButton: View {
    let content: String
    var state: QuestionState
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(content)
                .foregroundColor(.black)
                .frame(width: 120, height: 90)
                .background(backgroundColor(state: state))
                .cornerRadius(15)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(borderColor(state: state), lineWidth: 2)
                )
        }
        .disabled(state == .isValid)
    }
    
    private func backgroundColor(state: QuestionState) -> Color {
        switch state {
        case .isNeutral:
            return .white
        case .isSelected:
            return .blue.opacity(0.2) // Adjust the opacity for better visibility
        case .isValid:
            return .green.opacity(0.2)
        case .isWrong:
            return .red.opacity(0.2)
        }
    }
    
    private func borderColor(state: QuestionState) -> Color {
        switch state {
        case .isNeutral:
            return .gray
        case .isSelected:
            return .blue
        case .isValid:
            return .green
        case .isWrong:
            return .red
        }
    }
}

#Preview {
    MatchingButton(content: "Test", state: .isValid, action: {})
}
