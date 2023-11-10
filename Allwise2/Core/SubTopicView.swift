//
//  SubTopicView.swift
//  Allwise2
//
//  Created by Hugo Peyron on 10/11/2023.
//

import SwiftUI

struct SubTopicView: View {
    @EnvironmentObject var vm: AppViewModel
    let subTopic: SubTopic
    
    @State private var triggerQuitAlert: Bool = false
    
    @State private var isAnswerSelected: Bool = false
    
    @Environment(\.dismiss) private var dismiss
    
    // Computed property to calculate progress
    private var subTopicProgress: Float {
        let totalQuestions = subTopic.questions.count
        let solvedQuestions = subTopic.questions.filter { $0.isSolved }.count
        // Avoid division by zero
        return totalQuestions > 0 ? Float(solvedQuestions) / Float(totalQuestions) : 0
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                if let firstQuestion = subTopic.questions.first {
                    QuestionView(question: firstQuestion)
                        .environmentObject(vm)
                } else {
                    ProgressView()
                }
                
                answerValidationButton(isActive: $isAnswerSelected) {
//                    vm.checkAnswer()
                }
            }
            .toolbar {
                
                ToolbarItem(placement: .topBarLeading) {
                    XMark
                }
                
                ToolbarItem(placement: .principal) {
                    CustomProgressBar(progress: subTopicProgress)
                        .frame(width: 240)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    HStack {
                        Text("❤️")
                        Text("15")
                    }
                }
            }
            
            .navigationBarBackButtonHidden()
            .alert("Are you sure you want to quit?", isPresented: $triggerQuitAlert) {
                Button("Quit", role: .destructive) { dismiss() }
                Button("Continue", role: .cancel) { }
        }
        }
    }
    
    var XMark: some View {
        Button {
            triggerQuitAlert.toggle()
        } label: {
            Image(systemName: "xmark")
                .foregroundColor(.gray)
                .bold()
                .font(.title3)
        }
    }
}

#Preview {
    SubTopicView(subTopic: SubTopic(name: "Test", questions: [], isSolved: false))
        .environmentObject(AppViewModel())
}


struct answerValidationButton : View {
    
    // The button is active when at one answer is selected.
    @Binding var isActive : Bool
    @State var action : () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Text("Check")
                .frame(maxWidth: .infinity, minHeight: 50)
                .foregroundStyle(isActive ? .white : .gray)
                .font(.title)
                .bold()
                .fontDesign(.rounded)
                .background(isActive ? .green : .gray.opacity(0.3))
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .padding()
        }
        .disabled(!isActive)
    }
}
