//
//  ValidationButton.swift
//  Allwise2
//
//  Created by Hugo Peyron on 14/11/2023.
//

import SwiftUI

struct ValidationButton : View {
    
    @ObservedObject var lifesManager = LifesManager.shared
    var questionState: QuestionState
    let isCheckingForLifesCount: Bool
    var action : () -> Void
    
    @State private var offset: CGFloat = 2
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(shadowbackgroundColor())
                .frame(maxWidth: .infinity, maxHeight: 50)
                .offset(y: offset)
            
            Text(content())
                .frame(maxWidth: .infinity, maxHeight: 50)
                .foregroundColor(questionState != .isNeutral ? .white : .gray)
                .font(.title2)
                .bold()
                .fontDesign(.rounded)
                .background(backgroundColor())
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .offset(y: -offset)
        }
        .disabled(questionState == .isNeutral)
        .padding()
        .contentShape(RoundedRectangle(cornerRadius: 15))
        .gesture(
            DragGesture(minimumDistance: 0)
                .onChanged({ _ in
                    self.offset = 0
                })
                .onEnded({ _ in
                    
                    withAnimation(.snappy){
                        self.offset = 2
                        
                        if isCheckingForLifesCount{
                            if lifesManager.hasEnoughLifes {
                                action()
                            } else {
                                lifesManager.triggerModal = true
                            }
                        } else {
                            action()
                        }
                    }
                    
                })
        )
        
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
            return .duoBlue
        case .isValid:
            return .duoGreen
        case .isWrong:
            return .duoRed
        case .isNeutral:
            return .paleGray
        }
    }
    
    func shadowbackgroundColor() -> Color {
        switch questionState {
        case .isSelected:
            return .darkBlue
        case .isValid:
            return .darkGreen
        case .isWrong:
            return .darkRed
        case .isNeutral:
            return .gray
        }
    }
}

#Preview {
    ValidationButton(questionState: .isWrong, isCheckingForLifesCount: false, action: {})
}
