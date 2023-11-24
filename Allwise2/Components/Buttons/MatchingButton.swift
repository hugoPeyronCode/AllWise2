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
                .fixedSize(horizontal: false, vertical: true) // Allow text to wrap and expand vertically.
                .padding(.horizontal) // Add horizontal padding.
                .foregroundStyle(state == .isValid ? .duoGreen : state == .isWrong ? .duoRed : .primary)
                .frame(maxWidth: .infinity, minHeight: 50, maxHeight: 100)
                .background(color(state: state).opacity(0.2))
                .cornerRadius(15)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(color(state: state), lineWidth: 2)
                )
        }
        .disabled(state == .isValid)
    }
    
    private func color(state: QuestionState) -> Color {
        switch state {
        case .isNeutral:
            return .paleGray
        case .isSelected:
            return .duoBlue // Adjust the opacity for better visibility
        case .isValid:
            return .duoGreen
        case .isWrong:
            return .duoRed
        }
    }
}

#Preview {
    MatchingButton(content: "Test", state: .isValid, action: {})
}
