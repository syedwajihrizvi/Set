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
    
    static func isSet() -> Bool {
        return true
    }
    
    static func == (lhs: SetCardContent, rhs: SetCardContent) -> Bool {
        return lhs.shape == rhs.shape &&
        lhs.number == rhs.number &&
        lhs.shading == rhs.shading &&
        lhs.color == rhs.color
    }
}
