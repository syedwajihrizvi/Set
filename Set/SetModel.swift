//
//  SetModel.swift
//  Set
//
//  Created by Wajih Rizvi on 2022-08-27.
//

import Foundation

struct SetModel<CardContent> {
    private(set) var deck: Array<Card>
    private(set) var dealedCards: Array<Card>
    private(set) var chosenCards: Array<Card>
    private(set) var score: Int = 0
    
    private var currentDeckCard: Int = 0
    
    mutating func choose(card: Card) {
        if let chosenCardIndex = dealedCards.firstIndex(where: { $0.id == card.id }) {
            // If chosen card count is less than 3, either add to chosenCards, or remove
            if chosenCards.count < 3 {
                if dealedCards[chosenCardIndex].isSelected {
                    dealedCards[chosenCardIndex].isSelected = false
                    chosenCards.removeAll(where: { $0.id == card.id})
                } else {
                    dealedCards[chosenCardIndex].isSelected.toggle()
                    chosenCards.append(dealedCards[chosenCardIndex])
                }
            }
            // If the chosen card count is equal to 3, see if matching set
            else {
                let setEval = isSet()
                if (setEval.0) {
                    if currentDeckCard < 81 {
                        // Replace matched cards with 3 new cards from the deck
                        for card in chosenCards {
                            if let indexOfMatchedChosenCard = dealedCards.firstIndex(where: { $0.id == card.id }) {
                                let cardFromDeck = deck[currentDeckCard]
                                dealedCards[indexOfMatchedChosenCard] = cardFromDeck
                            }
                            currentDeckCard += 1
                        }
                    } else {
                        // If deck empty, remove the 3 matched cards from the table
                        for card in chosenCards {
                            if let indexOfMatchedChosenCard = dealedCards.firstIndex(where: { $0.id == card.id }) {
                                dealedCards.remove(at: indexOfMatchedChosenCard)
                            }
                        }
                    }
                    if chosenCards.firstIndex(where: { $0.id == card.id}) == nil {
                        // Assume the card selected was not from the matching set
                        dealedCards[chosenCardIndex].isSelected.toggle()
                        chosenCards.removeAll()
                        chosenCards.append(dealedCards[chosenCardIndex])
                    } else {
                        chosenCards.removeAll()
                    }
                    score += (setEval.1 * 2)
                } else {
                    for card in chosenCards {
                        if let indexOfChosenCard = dealedCards.firstIndex(where: { $0.id == card.id }) {
                            dealedCards[indexOfChosenCard].isSelected = false
                        }
                    }
                    chosenCards.removeAll()
                    dealedCards[chosenCardIndex].isSelected.toggle()
                    chosenCards.append(dealedCards[chosenCardIndex])
                    score -= 1
                }
            }
        }
    }
    
    private func isSet() -> (Bool, Int) {
        let chosenCardContents = chosenCards.map { $0.content }
        return SetCardContent.isSet(cards: chosenCardContents as! [SetCardContent])
    }
    
    init(cards gameCards: [CardContent]) {
        deck = []
        dealedCards = []
        chosenCards = []
        for index in gameCards.indices {
            deck.append(Card(content: gameCards[index]))
        }
        deck.shuffle()
        dealCards(amount: 12)
    }
  
    mutating func newGame() {
        dealedCards.removeAll()
        chosenCards.removeAll()
        currentDeckCard = 0
        deck.shuffle()
        dealCards(amount: 12)
        score = 0
    }
    
    mutating func dealCards(amount: Int) {
        if currentDeckCard < 81 {
            var cardsLeftToDeal = amount
            while (cardsLeftToDeal > 0) {
                let selectedCard = deck[currentDeckCard]
                dealedCards.append(selectedCard)
                cardsLeftToDeal -= 1
                currentDeckCard += 1
            }
        }
    }
    
    struct Card: Identifiable {
        var content: CardContent
        var isSelected: Bool = false
        var isMatch: Bool = false
        let id = UUID()
    }
}

