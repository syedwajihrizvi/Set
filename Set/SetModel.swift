//
//  SetModel.swift
//  Set
//
//  Created by Wajih Rizvi on 2022-08-27.
//

import Foundation

struct SetModel<CardContent> {
    private(set) var cards: Array<Card>
    private(set) var chosenCardCount: Int = 0
    
    mutating func choose(card: Card) {
        if chosenCardCount < 3 {
            if let chosenCardIndex = cards.firstIndex(where: { $0.id == card.id }) {
                cards[chosenCardIndex].isFaceUp.toggle()
            }
            chosenCardCount += 1
        } else {
            chosenCardCount = 0
            for index in cards.indices {
                cards[index].isFaceUp = false
            }
        }

    }
    
    mutating func addThreeMoreCards(createCardContent: () -> CardContent) {
        var currentID = cards.count
        for _ in 0...2 {
            let content = createCardContent()
            cards.append(Card(content: content, id: currentID))
            currentID += 1
        }
    }
    
    mutating func newGame(createCardContent: () -> CardContent) {
        cards = []
        for index in 0...11 {
            let content = createCardContent()
            cards.append(Card(content: content, id: index))
        }
    }
    
    init(numberOfCards: Int, createCardContent: () -> CardContent) {
        cards = []
        for index in 0..<numberOfCards {
            let content = createCardContent()
            cards.append(Card(content: content, id: index))
        }
    }
    
    struct Card: Identifiable {
        var content: CardContent
        var isFaceUp: Bool = true
        var id: Int
    }
}

