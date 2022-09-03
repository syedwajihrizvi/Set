//
//  Rectangle.swift
//  Set
//
//  Created by Wajih Rizvi on 2022-08-27.
//

import SwiftUI

struct Rectangle: Shape {
    var width: CGFloat
    var aspectRatio: CGFloat
    func path(in rect: CGRect) -> Path {
        let p = Path(CGRect(x: 0, y: 0, width: self.width, height: self.width/self.aspectRatio))
        return p
    }
    
}
