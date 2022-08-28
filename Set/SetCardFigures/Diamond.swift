//
//  Diamond.swift
//  Set
//
//  Created by Wajih Rizvi on 2022-08-27.
//

import SwiftUI

struct Diamond: Shape {
    var length: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let middle = length*0.5
        let offset = length * 0.1
        var p = Path()
        p.move(to: CGPoint(x: 0, y: middle))
        p.addQuadCurve(to: CGPoint(x: middle, y: 0),
                       control: CGPoint(x: middle-offset, y: middle-offset))
        p.addQuadCurve(to: CGPoint(x: length, y: middle),
                       control: CGPoint(x: middle+offset, y: middle-offset))
        p.addQuadCurve(to: CGPoint(x: middle, y: length),
                       control: CGPoint(x: middle+offset, y: middle-offset))
        p.addQuadCurve(to: CGPoint(x: 0, y: middle),
                       control: CGPoint(x: middle-offset, y: middle-offset))
        return p
    }
}

