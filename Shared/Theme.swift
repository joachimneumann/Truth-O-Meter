//
//  Theme.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 22/08/2021.
//

import Foundation

struct Result {
    var top: String
    var bottom: String?
    init(_ top_: String, _ bottom_: String?) { top = top_; bottom = bottom_ }
}

struct Theme: Identifiable, Equatable {
    private(set) var id: Int
    var title: String
    var results: [TapPrecision:Result]
    
    init(index: Int, title: String, results: [TapPrecision:Result]) {
        self.id = index
        self.title = title
        self.results = results
    }
    
    static func == (lhs: Theme, rhs: Theme) -> Bool {
        return lhs.id == rhs.id
    }
    
}
