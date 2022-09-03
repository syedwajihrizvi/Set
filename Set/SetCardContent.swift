//
//  CardContent.swift
//  Set
//
//  Created by Wajih Rizvi on 2022-08-27.
//

import Foundation
import SwiftUI

struct SetCardContent: Equatable {
    var number: Int
    var shading: Double
    var shape: String
    var color: Color
    
    static func isSet(cards: [SetCardContent]) -> (Bool, Int) {
        // Make sure they have the same shading
        let shades = Set(cards.map { $0.shading })
        let numbers = Set(cards.map { $0.number })
        let shapes = Set(cards.map { $0.shape })
        let colors = Set(cards.map { $0.color })
        var sameFeatures = 0
        // Shading
        if (shades.count == 3) {
            sameFeatures += 1
        }
        // Numbers
        if (numbers.count == 3) {
            sameFeatures += 1
        }
        // Shapes
        if (shapes.count == 3) {
            sameFeatures += 1
        }
        // Colors
        if (colors.count == 3) {
            sameFeatures += 1
        }
        if ((shades.count == 1 || shades.count == 3) &&
            (numbers.count == 1 || numbers.count == 3) &&
            (shapes.count == 1 || shapes.count == 3) &&
            (colors.count == 1 || colors.count == 3)) {
            return (true, sameFeatures)
        }
        return (false, sameFeatures)
    }
    
    static func == (lhs: SetCardContent, rhs: SetCardContent) -> Bool {
        return lhs.shape == rhs.shape &&
        lhs.number == rhs.number &&
        lhs.shading == rhs.shading &&
        lhs.color == rhs.color
    }
}
