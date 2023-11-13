//
//  SubTopicView.swift
//  Allwise2
//
//  Created by Hugo Peyron on 10/11/2023.
//

import SwiftUI

struct SubTopicView: View {
    @EnvironmentObject var vm : AppViewModel
    @StateObject var localVM : SubTopicViewModel
    @Environment(\.dismiss) private var dismiss
    
    var onComplete: (Bool) -> Void
    @State private var backToTopicView = false

    init(subTopic: SubTopic, onComplete: @escaping (Bool) -> Void) {
        _localVM = StateObject(wrappedValue: SubTopicViewModel(subTopic: subTopic))
        self.onComplete = onComplete
    }

    
    var body: some View {
        NavigationStack {
            GeometryReader { screen in
                VStack {
                    Text("Total question Count: \(localVM.subTopic.questions.count + localVM.errorQuestions.count)")
                    Text("Total error Count: \(localVM.errorQuestions.count)")
                    Text("Answered Question: \(localVM.answeredQuestionsCount)")
                    Text("Progress: \(localVM.subTopicProgress)")
                    QuestionView(question: localVM.currentQuestion,
                                 result: $localVM.questionViewResult,
                                 action1: { localVM.checkResult(for: localVM.currentQuestion)},
                                 action2: localVM.moveToNextQuestion)
                                .environmentObject(vm)
                }
            }
            .sheet(isPresented: $localVM.triggerErrorsView, content: {
                Text("Error view")
            })
            .fullScreenCover(isPresented: $localVM.triggerResultView) {
                Text("Back to topic View")
                    .onTapGesture {
                        onComplete(true) // Call the completion handler with true
                        dismiss()       // Dismiss the view to go back
                    }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    XMark
                }
                ToolbarItem(placement: .principal) {
                    CustomProgressBar(progress: localVM.subTopicProgress)
                        .frame(width: 240, height: 10)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    HStack {
                        Text("❤️")
                        Text("15")
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
            .alert("Are you sure you want to quit?", isPresented: $localVM.triggerQuitAlert) {
                Button("Quit", role: .destructive) { dismiss() }
                Button("Continue", role: .cancel) { }
            }
        }
    }
    
    var XMark: some View {
        Button {
            localVM.triggerQuitAlert.toggle()
        } label: {
            Image(systemName: "xmark")
                .foregroundColor(.gray)
                .bold()
                .font(.title3)
        }
    }
}
#Preview {
    SubTopicView(subTopic: SubTopic(name: "1",
                                    questions:
                                        [
                                            Question(question: "Question 1", explanation: "", answers: [
                                                Answer(text: "Bonne réponse", isTrue: true),
                                                Answer(text: "Mauvaise réponse", isTrue: false),
                                                Answer(text: "Mauvaise réponse", isTrue: false),
                                                Answer(text: "Mauvaise réponse", isTrue: false)
                                            ],
                                                     isSolved: false, type: .choice),
                                            Question(question: "Question 2", explanation: "", answers: [
                                                Answer(text: "Bonne réponse", isTrue: true),
                                                Answer(text: "Mauvaise réponse", isTrue: false),
                                                Answer(text: "Mauvaise réponse", isTrue: false),
                                                Answer(text: "Mauvaise réponse", isTrue: false)
                                            ],
                                                     isSolved: false, type: .duo)
                                        ],
                                    isSolved: false), onComplete: {_ in })
    .environmentObject(AppViewModel())
}
