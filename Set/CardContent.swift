//
//  CardContent.swift
//  Set
//
//  Created by Wajih Rizvi on 2022-08-27.
//

import Foundation

struct CardContent: Equatable {
    var number: Int
    var shading: Int
    var shape: String
    var color: String
    
    static func == (lhs: CardContent, rhs: CardContent) -> Bool {
        return lhs.shape == rhs.shape &&
        lhs.number == rhs.number &&
        lhs.shading == rhs.shading &&
        lhs.color == rhs.color
    }
}
