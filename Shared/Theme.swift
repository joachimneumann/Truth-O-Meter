//
//  Theme.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 22/08/2021.
//

import Foundation

struct StampTexts {
    let top: String
    let bottom: String?
    init(_ top_: String, _ bottom_: String?) { top = top_; bottom = bottom_ }
}
struct Theme {
    let displayText: String
    let farRight: StampTexts
    let right:    StampTexts
    let center:   StampTexts
    let left:     StampTexts
    let farLeft:  StampTexts
}
