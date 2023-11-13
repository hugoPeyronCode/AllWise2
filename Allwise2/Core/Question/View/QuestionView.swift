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
        VStack {
            QuestionField
            
            ForEach(question.answers, id: \.id) { answer in
                answerButton(for: answer)
            }
            .disabled(localVM.questionState == .isValid || localVM.questionState == .isWrong)
            
            HStack {
                ValidationButton(isActive: localVM.isAnswersArrayContainsSomething(for: localVM.selectedAnswers)) {
                    LocalCheckResult()
                    localVM.isMoveToNextPageButtonAppears = true
                }
                
                if localVM.isMoveToNextPageButtonAppears {
                    MoveToNextQuestionButton
                }
            }
        }
        .onAppear {
            print("question view appears")
        }
    }
    
    var MoveToNextQuestionButton : some View {
        Button {
            withAnimation(.bouncy) {
                localVM.selectedAnswers.removeAll()
                localVM.questionState = .isNeutral
                localVM.isMoveToNextPageButtonAppears = false
                action2()
            }
        } label: {
            Image(systemName: "chevron.right")
                .font(.title)
                .bold()
                .foregroundStyle(.white)
                .frame(width: 50, height: 50)
                .background(.blue)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .padding(.trailing)
                
        }
    }
    
    private func LocalCheckResult() {
        if localVM.selectedAnswers.first?.isTrue == true {
            vm.markQuestionAsSolved(for: question.id)
            localVM.questionState = .isValid
            result = true
            withAnimation(.bouncy) {
                action1()
            }
        } else {
            localVM.questionState = .isWrong
            result = false
            withAnimation(.bouncy) {
                action1()
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
                .frame(maxWidth: .infinity, maxHeight: 300)
                .background(RoundedRectangle(cornerRadius: 25)
                    .stroke(Color.black, lineWidth: 2)
                    .background(RoundedRectangle(cornerRadius: 15).fill(.thinMaterial)))
                .padding()
        }
    }
}

#Preview {
    QuestionView(question: Question(
        question: "Quelle est la couleur du cheval blanc d'Henri IV ?",
        explanation: "La réponse est dans la question",
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


struct SingleSelectButton : View {
    
    let answer : Answer
    @Binding var selectedAnswers: [Answer]
    @Binding var questionState : QuestionState
    
    var action : () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            RoundedRectangle(cornerRadius: 50)
                .strokeBorder( isSelected() ? color(questionState: questionState) : .gray, lineWidth: isSelected() ? 3 : 2)
                .background(RoundedRectangle(cornerRadius: 50).fill(color(questionState: questionState).opacity(0.5)).opacity(isSelected() ? 0.2 : 0))
                .overlay {
                    Text(answer.text)
                        .foregroundStyle(.foreground)
                        .font(.body)
                        .fontDesign(.rounded)
                        .fontWeight(.bold)
                }
                .frame(maxWidth: 350, maxHeight: 50)
                .padding(.horizontal)
        }
    }
    // Handle selection of the button
    func isSelected() -> Bool {
        selectedAnswers.contains { $0.id == answer.id }
    }
    
    // Handle color of the button according to state
    func color(questionState: QuestionState) -> Color {
        switch questionState {
        case .isSelected:
            return .blue
        case .isValid:
            return .green
        case .isWrong:
            return .red
        case .isNeutral:
            return .gray
        }
    }
}



struct ValidationButton : View {
    
    var isActive: Bool
    var action : () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Text("Check")
                .frame(maxWidth: .infinity, maxHeight: 60)
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
