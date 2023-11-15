//
//  QuestionView.swift
//  Allwise2
//
//  Created by Hugo Peyron on 10/11/2023.
//

import SwiftUI

enum QuestionState {
    case isSelected
    case isValid
    case isWrong
    case isNeutral
}

struct QuestionView: View {
    
    @EnvironmentObject var vm: AppViewModel
    @StateObject var localVM = QuestionViewModel()
    
    let question : Question
    
    @Binding var result : Bool? // Send the result of the question back to the subTopicView
    @State var action1 : () -> Void // CheckResult
    var action2: () -> Void // MoveToNextQuestion
    
    var body: some View {
        ZStack {
            
            VStack {
                
                QuestionField
                
                
                AnswerField
                
                Spacer()
                
                ValidationButton(questionState: localVM.questionState) {
                        validationButtonActions()
                    }

            }
            
            if localVM.showResultOverlay {
                    ResultOverlay(message: localVM.resultOverMessage,
                                  explanation: question.explanation,
                                  iconName: localVM.resultOverlayIcon,
                                  backgroundColor: localVM.resultOverlayColor,
                                  textColor: localVM.resultOverlayFontColor,
                                  questionState: localVM.questionState) {
                        validationButtonActions()
                    }
            }
        }
    }
    
    func validationButtonActions() {
        switch localVM.questionState {
        case .isSelected:
            LocalCheckResult()
        case .isValid:
            withAnimation(.bouncy) {
                localVM.selectedAnswers.removeAll()
                localVM.questionState = .isNeutral
                localVM.isMoveToNextPageButtonAppears = false
                action2()
            }
        case .isWrong:
            withAnimation(.bouncy) {
                localVM.selectedAnswers.removeAll()
                localVM.questionState = .isNeutral
                localVM.isMoveToNextPageButtonAppears = false
                action2()
            }
        case .isNeutral:
            localVM.questionState = .isNeutral
        }
    }
    
    func DoNothing() {
        print("I do nothing")
    }
    
    private func LocalCheckResult() {
        if localVM.selectedAnswers.first?.isTrue == true {
            vm.markQuestionAsSolved(for: question.id)
            localVM.questionState = .isValid
            result = true
            withAnimation(.snappy) {
                action1()
                localVM.showResultOverlay.toggle()
                localVM.updateResultOverlay()
            }
        } else {
            localVM.questionState = .isWrong
            result = false
            withAnimation(.snappy) {
                action1()
                localVM.showResultOverlay.toggle()
                localVM.updateResultOverlay()
            }
        }
    }
    
    private func answerButton(for answer: Answer) -> some View {
        SingleSelectButton(answer: answer, selectedAnswers: $localVM.selectedAnswers, questionState: $localVM.questionState) {
            localVM.questionState = .isSelected
            localVM.selectedAnswers.removeAll()
            localVM.selectedAnswers.append(answer)
        }
    }
    
    var QuestionField : some View {
        VStack {
            Text(question.question)
                .font(.title3)
                .fontDesign(.rounded)
                .multilineTextAlignment(.center)
                .padding()
                .frame(maxWidth: .infinity, maxHeight: 220)
                .background(RoundedRectangle(cornerRadius: 25)
                    .stroke(Color.black, lineWidth: 2)
                    .background(RoundedRectangle(cornerRadius: 15).fill(.thinMaterial)))
                .padding()
        }
    }
    
    var AnswerField : some View {
        ForEach(question.answers, id: \.id) { answer in
            answerButton(for: answer)
        }
        .disabled(localVM.questionState == .isValid || localVM.questionState == .isWrong)
    }

}

#Preview {
    QuestionView(question: Question(
        question: "Quelle est la couleur du cheval blanc d'Henri IV ?", image: "",
        explanation: "La réponse est dans la question, La réponse est dans la question",
        answers: [
            Answer(text: "Blanc", isTrue: true),
            Answer(text: "Bleu", isTrue: false),
            Answer(text: "Beige", isTrue: false),
            Answer(text: "Noir", isTrue: false)
        ],
        isSolved: false,
        type: .duo
    ), result: .constant(false), action1: {}, action2: {}
    )
    .environmentObject(AppViewModel())
}
