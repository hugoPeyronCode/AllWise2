//
//  ResultOverlay.swift
//  Allwise2
//
//  Created by Hugo Peyron on 14/11/2023.
//

import SwiftUI

struct ResultOverlay: View {
    
    @StateObject var vm = ResultOverlayViewModel()
    
    @ObservedObject var lifesManager = LifesManager.shared
    
    let explanation : String
    @State var questionState : QuestionState
    @State var actions: () -> Void

    var body: some View {
        VStack {
            Spacer()
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Image(systemName: vm.icon)
                    Text(vm.message)
                    Spacer()
                }
                .padding(.top)
                .padding(.horizontal)
                .font(.title)
                .bold()
                
                Text(vm.explanation)
                    .bold()
                    .font(.body)
                    .padding()
                
                ValidationButton(questionState: questionState, isCheckingForLifesCount: true) {
                    if lifesManager.hasEnoughLifes {
                        actions()
                    } else {
                        lifesManager.triggerModal = true
                    }
                }
            }
            .fontDesign(.rounded)
            .frame(maxWidth: .infinity)
            .background(vm.color)
            .foregroundColor(vm.fontColor)
        }
        .transition(.move(edge: .bottom))
        .onAppear{
            vm.updateContent(questionExplanation: explanation, questionState: questionState)
        }
    }
}


#Preview {
    ResultOverlay(explanation: "questionExplanation", questionState: .isSelected, actions: {})
}
