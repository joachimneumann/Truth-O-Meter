//
//  Precision.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 25/08/2021.
//

import Foundation
import CoreGraphics

enum Precision {
    case edge, outer, middle, inner, bullsEye
    
    func padding(radius: CGFloat) -> CGFloat {
        // Instead of 0, 0.2, 0.4, 0.6, 0.8, 1.0
        // I make the bulls eye and the out disk a bit larger
        // This makes the edge results easier to hit.
        let tapEdge:CGFloat     = 1.0
        let tapOuter:CGFloat    = 0.8 - 0.05
        let tapMiddle:CGFloat   = 0.6 - 0.0125
        let tapInner:CGFloat    = 0.4 + 0.0125
        let tapBullsEye:CGFloat = 0.2 + 0.05
        switch self {
        case .edge:
            return radius * (1.0 - tapEdge)
        case .outer:
            return radius * (1.0 - tapOuter)
        case .middle:
            return radius * (1.0 - tapMiddle)
        case .inner:
            return radius * (1.0 - tapInner)
        case .bullsEye:
            return radius * (1.0 - tapBullsEye)
        }
    }
}
