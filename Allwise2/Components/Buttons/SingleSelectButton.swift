//
//  SingleSelectButton.swift
//  Allwise2
//
//  Created by Hugo Peyron on 14/11/2023.
//

import SwiftUI

struct SingleSelectButton : View {
    
    @ObservedObject var lifesManager = LifesManager.shared
    
    let answer : Answer
    @Binding var selectedAnswers: [Answer]
    @Binding var questionState : QuestionState
    
    var action : () -> Void
    
    var body: some View {
        Button {
            
            if lifesManager.hasEnoughLifes {
                withAnimation(.snappy){
                    action()
                }
            } else {
                withAnimation(.snappy){
                    lifesManager.triggerModal = true
                }
            }

        } label: {
            RoundedRectangle(cornerRadius: 15)
                .strokeBorder( isSelected() ? color(questionState: questionState) : .gray, lineWidth: isSelected() ? 3 : 2)
                .background(RoundedRectangle(cornerRadius: 50).fill(color(questionState: questionState).opacity(0.5)).opacity(isSelected() ? 0.2 : 0))
                .overlay {
                    Text(answer.text)
                        .foregroundStyle(.foreground)
                        .font(.body)
                        .fontDesign(.rounded)
                        .fontWeight(.bold)
                }
                .frame(maxWidth: 350, maxHeight: 50)
                .padding(.horizontal)
        }
    }
    // Handle selection of the button
    func isSelected() -> Bool {
        selectedAnswers.contains { $0.id == answer.id }
    }
    
    // Handle color of the button according to state
    func color(questionState: QuestionState) -> Color {
        switch questionState {
        case .isSelected:
            return .blue
        case .isValid:
            return .green
        case .isWrong:
            return .red
        case .isNeutral:
            return .gray
        }
    }
}

#Preview {
    SingleSelectButton(answer: Answer(text: "This is the good answer", isTrue: true), selectedAnswers: .constant([]), questionState: .constant(.isSelected), action: {})
}
