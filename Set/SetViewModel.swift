//
//  SetViewModel.swift
//  Set
//
//  Created by Wajih Rizvi on 2022-08-27.
//

import Foundation
import SwiftUI

class SetViewModel: ObservableObject {
    typealias Card = SetModel<SetCardContent>.Card
    
    private static let colors = ["red", "green", "blue"]
    private static let shapes = ["rectangle", "triangle", "diamond"]
    private static let amounts = [1, 2, 3]
    private static let shades = [0, 0.3, 1]
    
    private static func createSetCards() -> [SetCardContent] {
        var cards: [SetCardContent] = []
        for color in colors {
            for shape in shapes {
                for amount in amounts {
                    for shade in shades {
                        var cardColor: Color = Color.pink
                        if (color == "red") {
                            cardColor = Color.red
                        }
                        if (color == "green") {
                            cardColor = Color.green
                        }
                        if (color == "blue") {
                            cardColor = Color.blue
                        }
                        cards.append(SetCardContent(number: amount,
                                                 shading: shade,
                                                 shape: shape,
                                                 color: cardColor))
                    }
                }
            }
        }
        return cards
    }
    
    private static func createSetGame() -> SetModel<SetCardContent> {
        let setCards = createSetCards()
        return SetModel<SetCardContent>(cards: setCards)
    }
    
    @Published private var model = createSetGame()
    
    var cards: Array<Card> {
        return model.dealedCards
    }

    var score: Int {
        return model.score
    }
    
    // MARK:  - Intents
    func choose(card: Card) {
        model.choose(card: card)
    }
    
    func addThreeMoreCards() {
        model.dealCards(amount: 3)
    }
    
    func newGame() {
        model.newGame()
    }
    
}
