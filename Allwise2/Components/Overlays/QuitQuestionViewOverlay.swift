//
//  QuitQuestionViewOverlay.swift
//  Allwise2
//
//  Created by Hugo Peyron on 14/11/2023.
//

import SwiftUI

struct QuitQuestionViewOverlay: View {
    
    var onContinueLearning: () -> Void
    var onEndSession: () -> Void
    
    @State var emoji: String = "🥺"
    
    var body: some View {
        VStack {
            Spacer()
            VStack(alignment: .center, spacing: 8) {
                
                Text(emoji)
                    .font(.system(size: 100))
                
                Text("Wait, don't go!")
                    .bold()
                    .font(.title2)
                
                Text("You're right on track if you quit now you'll lose your progress.")
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.paleGray)
                    .bold()
                
                VStack{
                    Button("Keep learning", action: onContinueLearning)
                        .font(.title3)
                        .bold()
                        .foregroundStyle(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .padding()
                    
                    Button("End Session", action: onEndSession)
                        .font(.title3)
                        .foregroundStyle(.duoRed)
                    
                }
            }
            .fontDesign(.rounded)
            .frame(maxWidth: .infinity)
            .background(.white)
            .foregroundStyle(.foreground)
        }
        .transition(.move(edge: .bottom))
        .onDisappear {
            withAnimation {
                emoji = "😄"
            }
        }
    }
}

#Preview {
    QuitQuestionViewOverlay(onContinueLearning: {}, onEndSession: {})
}
