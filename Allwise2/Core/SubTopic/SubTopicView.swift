//
//  SubTopicView.swift
//  Allwise2
//
//  Created by Hugo Peyron on 10/11/2023.
//

import SwiftUI

struct SubTopicView: View {
    
//    @EnvironmentObject var vm : AppViewModel
    @ObservedObject var vm = AppViewModel.shared
    @ObservedObject var lifesManager = LifesManager.shared
    
    @StateObject var localVM : SubTopicViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State private var showQuitOverlay = false
    
    var onComplete: (Bool) -> Void
    @State private var backToTopicView = false
    
    @State private var disableAllView = false
    
    init(subTopic: SubTopic, onComplete: @escaping (Bool) -> Void) {
        _localVM = StateObject(wrappedValue: SubTopicViewModel(subTopic: subTopic))
        self.onComplete = onComplete
    }
    
    var body: some View {
        NavigationStack {
            GeometryReader { screen in
                ZStack {
                    VStack {
                        
                        switch localVM.subtopicViewState {
                        case .triggerErrorView:
                            ErrorViewField
                        case .triggerResultView:
                            ResultViewField
                        case .triggerQuestionView:
                            QuestionViewField
                                .disabled(disableAllView)
                        }
                    }
                    
                    if showQuitOverlay {
                        Color.reverseWhite.opacity(0.3)
                            .ignoresSafeArea()
                            .zIndex(2)
                        
                        QuitQuestionViewOverlay(
                            onContinueLearning: {
                                withAnimation(.snappy){
                                    self.showQuitOverlay = false
                                    
                                    if !lifesManager.hasEnoughLifes {
                                        
                                        disableAllView = true
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                            withAnimation {
                                                lifesManager.triggerModal = true
                                            }
                                            disableAllView = false
                                        }
                                    }
                                }
                            },
                            onEndSession: {
                                // Handle "End Session" action
                                dismiss()
                                self.onComplete(false)
                            }
                        )
                        .transition(.move(edge: .bottom))
                        .zIndex(3)
                    }
                    
                    if lifesManager.triggerModal {
                        Color.primary.opacity(0.3)
                            .ignoresSafeArea()
                            .zIndex(2)
                        
                        BuyNewLifesOverlay(
                            
                            onContinueLearning: {
                                
                            lifesManager.refillLifes(count: 3)
                            withAnimation {
                                lifesManager.triggerModal = false
                            }
                        }, onEndSession: {
                            lifesManager.triggerModal = false
                            withAnimation {
                                showQuitOverlay = true

                            }
                        })
                        .transition(.move(edge: .bottom))
                        .zIndex(3)
                    }
                }
            }
            .onAppear {
                localVM.startSession()
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    XMark
                        .disabled(localVM.subtopicViewState == .triggerResultView)
                }
                ToolbarItem(placement: .principal) {
                    CustomProgressBar(progress: localVM.subTopicProgress)
                        .frame(width: 240, height: 10)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    HStack {
                        Image(systemName: "heart.fill")
                            .foregroundStyle(.red)
                        Text("\(lifesManager.lifesCount)")
                            .font(.system(.body, design: .rounded, weight: .black))
                            .foregroundStyle(.reverseWhite.opacity(0.4))

                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
        }
    }
    
    var ErrorViewField : some View {
        ErrorsView {
            withAnimation(.snappy) {
                localVM.subtopicViewState = .triggerQuestionView
            }
        }
        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
    }
    
    var QuestionViewField : some View {
        QuestionQCMView(question: localVM.currentQuestion,
                     result: $localVM.questionViewResult,
                     action1: { localVM.checkResult(for: localVM.currentQuestion)},
                     action2: localVM.moveToNextQuestion)
        
        .environmentObject(vm)
        .id(localVM.currentQuestion.id)
        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
        .animation(.bouncy, value: localVM.currentQuestion.id)
        .disabled(showQuitOverlay)
    }
    
    var ResultViewField : some View {
        
        ResultView(accuracy: localVM.accuracy, speed: localVM.duration, totalXP: localVM.xp) {
            onComplete(true) // Call the completion handler with true
            dismiss()       // Dismiss the view to go back
        }
        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
    }
    
    var XMark: some View {
        Button {
            withAnimation(.snappy){
                showQuitOverlay.toggle()
            }
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
                                            Question(question: "Question 1", image: "", explanation: "", answers: [
                                                Answer(text: "Bonne réponse", isTrue: true),
                                                Answer(text: "Mauvaise réponse", isTrue: false),
                                                Answer(text: "Mauvaise réponse", isTrue: false),
                                                Answer(text: "Mauvaise réponse", isTrue: false)
                                            ],
                                                     isSolved: false, type: .qcm),
                                            Question(question: "Question 2", image: "", explanation: "", answers: [
                                                Answer(text: "Bonne réponse", isTrue: true),
                                                Answer(text: "Mauvaise réponse", isTrue: false),
                                                Answer(text: "Mauvaise réponse", isTrue: false),
                                                Answer(text: "Mauvaise réponse", isTrue: false)
                                            ],
                                                     isSolved: false, type: .qcm)
                                        ],
                                    isSolved: false), onComplete: {_ in })
    .environmentObject(AppViewModel())
}
