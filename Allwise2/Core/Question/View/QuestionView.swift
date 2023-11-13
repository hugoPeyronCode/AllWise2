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
    
    let question : Question
    
    @State private var selectedAnswers : [Answer] = []
    
    @State private var questionState : QuestionState = .isNeutral
    
    @Binding var result : Bool?
    
    @State private var isMoveToNextPageButtonAppears: Bool = false
    
    var action1 : () -> Void // CheckResult
    var action2: () -> Void // MoveToNextQuestion
    
    private var isValidationButtonActive: Bool {
          !selectedAnswers.isEmpty
      }
    
    var body: some View {
        VStack {
            QuestionField
            
            ForEach(question.answers, id: \.id) { answer in
                answerButton(for: answer)
            }
            .disabled(isValidationButtonActive)
            
            HStack {
                ValidationButton(isActive: isValidationButtonActive) {
                    LocalCheckResult()
                    isMoveToNextPageButtonAppears = true
                }
                
                if isMoveToNextPageButtonAppears {
                    MoveToNextQuestionButton
                }
            }
            
            Text("\(result.debugDescription)")
        }
    }
    
    var MoveToNextQuestionButton : some View {
        Button {
            action2()
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
        if selectedAnswers.first?.isTrue == true {
            questionState = .isValid
            result = true
            withAnimation(.bouncy) {
                action1()
            }
        } else {
            questionState = .isWrong
            result = false
            withAnimation(.snappy) {
                action1()
            }
        }
    }
    
    private func answerButton(for answer: Answer) -> some View {
        SingleSelectButton(answer: answer, selectedAnswers: $selectedAnswers, questionState: $questionState) {
            questionState = .isSelected
            selectedAnswers.removeAll()
            selectedAnswers.append(answer)
        }
    }
    
    var QuestionField : some View {
        VStack {
            Text(question.question)
                .font(.title3)
                .fontDesign(.rounded)
                .multilineTextAlignment(.center)
                .padding()
                .frame(maxWidth: .infinity, minHeight: 300)
                .background(RoundedRectangle(cornerRadius: 25)
                    .stroke(Color.black, lineWidth: 2)
                    .background(RoundedRectangle(cornerRadius: 15).fill(.thinMaterial)))
                .padding()
        }
    }
}

#Preview {
    QuestionView(question: Question(
        question: "Quel est la couleur du cheval blanc d'Henri IV ?",
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
                .frame(width: 350, height: 60)
                .padding(.horizontal)
        }
    }
    func isSelected() -> Bool {
        selectedAnswers.contains { $0.id == answer.id }
    }
    
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
