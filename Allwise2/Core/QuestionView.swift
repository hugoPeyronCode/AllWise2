//
//  QuestionView.swift
//  Allwise2
//
//  Created by Hugo Peyron on 10/11/2023.
//

import SwiftUI

struct QuestionView: View {
    
    @EnvironmentObject var vm: AppViewModel
    
    let question : Question
    
    //    let question = Question(
    //        question: "Quel est la couleur du cheval blanc d'Henri IV ?",
    //        explanation: "La réponse est dans la question",
    //        answers: [
    //            Answer(text: "Blanc", isTrue: true),
    //            Answer(text: "Bleu", isTrue: false),
    //            Answer(text: "Beige", isTrue: false),
    //            Answer(text: "Noir", isTrue: false)
    //        ],
    //        isSolved: false,
    //        type: .duo
    //    )
    
    @State var isSelected : Bool = false
    
    var body: some View {
        VStack {
            QuestionField
            
            ForEach(question.answers, id: \.id) { answer in
                answerButton(isSelected: $isSelected, answer: answer.text) {}
            }
            
        }
        .fixedSize(horizontal: false, vertical: true)
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
    )
    )
    .environmentObject(AppViewModel())
}


struct answerButton : View {
    @Binding var isSelected : Bool
    let answer : String
    
    @State var action : () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            RoundedRectangle(cornerRadius: 50)
                .strokeBorder(.black, lineWidth: isSelected ? 3 : 2)
                .background(RoundedRectangle(cornerRadius: 50).fill(.green.opacity(0.5)).opacity(isSelected ? 0.2 : 0))
                .overlay {
                    Text(answer)
                        .foregroundStyle(.foreground)
                        .font(.body)
                        .fontDesign(.rounded)
                        .fontWeight(.bold)
                }
                .frame(width: 350, height: 60)
                .padding(.horizontal)
        }
        
    }
}
