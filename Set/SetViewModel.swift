//
//  SetViewModel.swift
//  Set
//
//  Created by Wajih Rizvi on 2022-08-27.
//

import Foundation
import SwiftUI

class SetViewModel: ObservableObject {
    typealias Card = SetModel<String>.Card
    
    private static let colors = ["red", "green", "blue"]
    private static let shapes = ["rectangle", "triangle", "diamond"]
    private static let amount = [1, 2, 3]
    private static let shading = [1, 2, 3]
    
//    private static func createCardContent() -> CardContent {
//        
//    }
    
    private static func createSetGame() -> SetModel<String> {
        return SetModel<String>(numberOfCards: 12, createCardContent: {
            return "S"
        })
    }
    
    @Published private var model = createSetGame()
    
    var cards: Array<Card> {
        return model.cards
    }
    
    // MARK:  - Intents
    func choose(card: Card) {
        model.choose(card: card)
    }
    
    func addThreeMoreCards() {
        model.addThreeMoreCards(createCardContent: {return "S"})
    }
    
    func newGame() {
        model.newGame(createCardContent: {return "S"})
    }
}
