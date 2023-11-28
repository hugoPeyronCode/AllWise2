//
//  MatchThePairsView.swift
//  Allwise2
//
//  Created by Hugo Peyron on 22/11/2023.
//

import SwiftUI

struct MatchingView: View {
    @ObservedObject var vm : MatchingViewModel
    
    init(matchingQuestion: MatchingQuestion, result: Binding<Bool?>, checkResult: @escaping () -> Void, moveToNextQuestion: @escaping () -> Void) {
        let viewModel = MatchingViewModel(matchingQuestion: matchingQuestion)
        _vm = ObservedObject(wrappedValue: viewModel)
        _result = result
        self.checkResult = checkResult
        self.moveToNextQuestion = moveToNextQuestion
    }
    
    @Binding var result : Bool?
    
    @State var checkResult : () -> Void
    
    var moveToNextQuestion : () -> Void
    
    
    var body: some View {
        ZStack {
            VStack {
                
                Text("Match The Pairs")
                    .bold()
                    .font(.title)
                    .fontDesign(.rounded)
                    .padding()
                
                Spacer()
                
                HStack() {
                    Spacer()
                    QuestionButtonView(questionPairs: vm.shuffledQuestions, selectQuestion: vm.selectQuestion)
                    Spacer()
                    AnswerButtonView(answerPairs: vm.shuffledAnswers, selectAnswer: vm.selectAnswer)
                    Spacer()
                }
                
                .onChange(of: vm.selectedQuestionID) { newValue in
                    vm.checkMatch()
                }
                .onChange(of: vm.selectedAnswerID) { newValue in
                    vm.checkMatch()
                }
                
                Spacer()
                
                ValidationButton(questionState: vm.gameState, isCheckingForLifesCount: true) {
                    if vm.gameState == .isValid {
                        vm.showResultOverlay = true
                    }
                }
            }
            
            if vm.showResultOverlay {
                ResultOverlay(explanation: "You've matched all pairs!", questionState: .isValid) {
                    checkResult()
                    vm.markQuestionAsSolved()
                    result = true
                    moveToNextQuestion()
                }
            }
        }
    }
}

#Preview {
    MatchingView(matchingQuestion: MatchingQuestion(questions: [
        QuestionAnswerPair(question: "Question1", answer: "Answer1", questionState: .isNeutral, answerState: .isNeutral),
        QuestionAnswerPair(question: "Question2kjgkjgkjgkjgjkhg kjhgjhgjh jhgjhg", answer: "Answer2lhkjhkjhkjh ghjgjhg ", questionState: .isNeutral, answerState: .isNeutral),
        QuestionAnswerPair(question: "Question3 jhgjhgjh", answer: "Answer3 jhghgjhg", questionState: .isNeutral, answerState: .isNeutral),
        QuestionAnswerPair(question: "Question4hgjhgj ", answer: "Answer4jhg jh", questionState: .isNeutral, answerState: .isNeutral),
        QuestionAnswerPair(question: "Question5", answer: "Answer5", questionState: .isNeutral, answerState: .isNeutral)
    ], isSolved: false), result: .constant(false)){} moveToNextQuestion: {}
}


struct QuestionButtonView: View {
    var questionPairs: [QuestionAnswerPair]
    var selectQuestion: (UUID) -> Void
    
    var body: some View {
        VStack {
            ForEach(questionPairs) { pair in
                MatchingButton(
                    content: pair.question,
                    state: pair.questionState
                ) {
                    selectQuestion(pair.id)
                }
            }
        }
    }
}

struct AnswerButtonView: View {
    var answerPairs: [QuestionAnswerPair]
    var selectAnswer: (UUID) -> Void
    
    var body: some View {
        VStack {
            ForEach(answerPairs) { pair in
                MatchingButton(
                    content: pair.answer,
                    state: pair.answerState
                ) {
                    selectAnswer(pair.id)
                }
            }
        }
    }
}
