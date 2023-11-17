//
//  ResultOverlay.swift
//  Allwise2
//
//  Created by Hugo Peyron on 14/11/2023.
//

import SwiftUI

struct ResultOverlay: View {
    
    @ObservedObject var lifesManager = LifesManager.shared
    
    var message: String
    var explanation: String
    var iconName: String
    var backgroundColor: Color
    var textColor: Color
    
    @State var questionState : QuestionState
    @State var actions: () -> Void

    var body: some View {
        VStack {
            Spacer()
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Image(systemName: iconName)
                    Text(message)
                    Spacer()
                }
                .padding(.top)
                .padding(.horizontal)
                .font(.title)
                .bold()
                
                Text(explanation)
                    .bold()
                    .font(.body)
                    .padding()
                
                ValidationButton(questionState: questionState) {
                    if lifesManager.hasEnoughLifes {
                        actions()
                    } else {
                        lifesManager.triggerModal = true
                    }
                }
            }
            .fontDesign(.rounded)
            .frame(maxWidth: .infinity)
            .background(backgroundColor)
            .foregroundColor(textColor)
        }
        .transition(.move(edge: .bottom))
    }
}


#Preview {
    ResultOverlay(message: "Correct", explanation: "You must be wrong because the real message is definitely something else. ", iconName: "heart.fill", backgroundColor: .paleGreen, textColor: .duoGreen, questionState: .isValid, actions: {})
}
