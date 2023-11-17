//
//  QuestionMatchViewModel.swift
//  Allwise2
//
//  Created by Hugo Peyron on 17/11/2023.
//

import Foundation
import SwiftUI

class QuestionMatchViewModel: ObservableObject {
    
    @Published var cards: [HistoryCard] = []
    @Published var selectedCards: [HistoryCard] = []
    
    init() {
        // Prepare your card pairs
        let pair1 = UUID()
        let pair2 = UUID()
        // More pairs...

        cards = [
            HistoryCard(content: "1789", pairId: pair1),
            HistoryCard(content: "French Revolution", pairId: pair1),
            HistoryCard(content: "1945", pairId: pair2),
            HistoryCard(content: "End of WWII", pairId: pair2),
            // More pairs...
        ].shuffled() // Shuffle the cards to mix them up
    }
    
    func selectCard(_ card: HistoryCard) {
        guard !card.isMatched, selectedCards.count < 2 else { return }
        
        if let selectedIndex = cards.firstIndex(where: { $0.id == card.id }) {
            cards[selectedIndex].isSelected = !cards[selectedIndex].isSelected // Toggle selection
            
            if cards[selectedIndex].isSelected {
                selectedCards.append(cards[selectedIndex])
            } else {
                selectedCards.removeAll { $0.id == card.id }
            }
            
            if selectedCards.count == 2 {
                checkForMatch()
            }
        }
    }
    
    func checkForMatch() {
        if selectedCards.count == 2, selectedCards[0].pairId == selectedCards[1].pairId {
            // It's a match!
            setCardsMatched(withId: selectedCards[0].pairId)
            selectedCards.removeAll()
        } else if selectedCards.count == 2 {
            // Not a match
            if let firstIndex = cards.firstIndex(where: { $0.id == selectedCards[0].id }),
               let secondIndex = cards.firstIndex(where: { $0.id == selectedCards[1].id }) {
                cards[firstIndex].isSelected = false
                cards[secondIndex].isSelected = false
                
                // Delay to show the mismatch
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.cards[firstIndex].isSelected = false
                    self.cards[secondIndex].isSelected = false
                    self.selectedCards.removeAll()
                }
            }
        }
    }
    
    private func setCardsMatched(withId id: UUID) {
        for index in cards.indices where cards[index].pairId == id {
            cards[index].isMatched = true
            cards[index].isSelected = false // Also unselect the card
        }
    }
}
