//
//  MatchThePairsView.swift
//  Allwise2
//
//  Created by Hugo Peyron on 22/11/2023.
//

import SwiftUI

struct MatchingView: View {
    @ObservedObject var vm : MatchingViewModel
    
    @State private var shuffledQuestions: [QuestionAnswerPair] = []
    @State private var shuffledAnswers: [QuestionAnswerPair] = []

    init(vm: MatchingViewModel) {
        _vm = ObservedObject(initialValue: vm)
        _shuffledQuestions = State(initialValue: vm.pairs.shuffled())
        _shuffledAnswers = State(initialValue: vm.pairs.shuffled())
    }
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    ForEach(shuffledQuestions) { pair in
                        MatchingButton(
                            content: pair.question,
                            state: vm.pairs.first(where: { $0.id == pair.id })?.questionState ?? .isNeutral
                        ) {
                            vm.selectQuestion(pair.id)
                        }
                    }
                }
                
                VStack {
                    ForEach(shuffledAnswers) { pair in
                        MatchingButton(
                            content: pair.answer,
                            state: vm.pairs.first(where: { $0.id == pair.id })?.answerState ?? .isNeutral
                        ) {
                            vm.selectAnswer(pair.id)
                        }
                    }
                }
            }
            .onChange(of: vm.selectedQuestionID) { newValue in
                vm.checkMatch()
            }
            .onChange(of: vm.selectedAnswerID) { newValue in
                vm.checkMatch()
            }
            
            ValidationButton(questionState: vm.gameState, action: {
                vm.resetGame()
            })
            
        }
    }
}

#Preview {
    MatchingView(vm: MatchingViewModel())
}
