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

class Theme: Identifiable, Equatable {
    var id = UUID()
    let title: String
    let results: [TapPrecision:Result]

    init(title: String, results: [TapPrecision:Result]) {
        self.title = title
        self.results = results
    }
    
    static func == (lhs: Theme, rhs: Theme) -> Bool {
        return lhs.id == rhs.id
    }
    
}
