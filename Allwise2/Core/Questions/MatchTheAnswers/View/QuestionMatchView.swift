    //
    //  QuestionMatchView.swift
    //  Allwise2
    //
    //  Created by Hugo Peyron on 17/11/2023.
    //

    import SwiftUI

    struct QuestionMatchView: View {
        
        @StateObject var localVM = QuestionMatchViewModel()
        
        let columns = [GridItem(.flexible()), GridItem(.flexible())]

        var body: some View {
             VStack {
                 // Your other UI elements like the progress bar can go here
                 
                 // The grid of cards
                 LazyVGrid(columns: columns, spacing: 20) {
                     ForEach(localVM.cards) { card in
                         CardView(viewModel: localVM, card: card)
                             .onTapGesture {
                                 localVM.selectCard(card)
                             }
                     }
                 }
                 .padding()
                 
                 ValidationButton(questionState: LocalCheckResult()) {
                     //
                 }
                 
             }
         }
        
        func LocalCheckResult() -> QuestionState {
            
            var isValid = false
            
            for cards in localVM.cards {
                if cards.isMatched == true {
                    isValid = true
                } else {
                    isValid = false
                }
            }
            
            if isValid == true { return .isValid} else { return .isNeutral }
        }
    }

struct CardView: View {
    @ObservedObject var viewModel: QuestionMatchViewModel
    let card: HistoryCard
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(card.isMatched ? Color.green.opacity(0.1) : card.isSelected ? Color.blue : Color.white)
                .shadow(radius: 5)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(card.isMatched ? Color.green : card.isSelected ? Color.blue : Color.gray, lineWidth: 3)
                )
            
            Text(card.content)
        }
        .aspectRatio(1, contentMode: .fit)
        .animation(.easeIn, value: card.isMatched)
        .animation(.easeIn, value: card.isSelected)
    }
}

struct HistoryCard: Identifiable {
    let id = UUID()
    let content: String
    let pairId: UUID
    var isMatched: Bool = false
    var isSelected: Bool = false // State to track if the card is selected
}


    // Define your card model
    struct MathCard: Identifiable {
        let id = UUID()
        let number1: Int
        let number2: Int
        let isExpression: Bool
        
        var result: Int {
            return number1 * number2
        }
    }

    #Preview {
        QuestionMatchView()
    }
