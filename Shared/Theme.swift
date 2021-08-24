//
//  Theme.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 22/08/2021.
//

import Foundation

struct Result {
    let top: String
    let bottom: String?
    init(_ top_: String, _ bottom_: String?) { top = top_; bottom = bottom_ }
}

struct Theme: Identifiable {
    var id = UUID()
    let displayText: String
    let results: [Model.TapPrecision:Result]
}
