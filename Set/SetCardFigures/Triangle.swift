//
//  Triangle.swift
//  Set
//
//  Created by Wajih Rizvi on 2022-08-27.
//

import SwiftUI

struct Triangle: Shape {
    var width: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var p = Path()
        p.move(to: CGPoint(x: 0 * width, y: 1 * width))
        p.addLine(to: CGPoint(x: 1 * width, y: 1 * width))
        p.addLine(to: CGPoint(x: 0.5 * width, y: 0 * width))
        p.closeSubpath()
        return p
    }
    
    
}

