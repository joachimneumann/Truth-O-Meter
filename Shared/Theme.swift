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

struct Results {
    var edge: Result
    var outer: Result
    var middle: Result
    var inner: Result
    var bullsEye: Result
}


struct Theme: Identifiable, Equatable {
    private(set) var id: Int
    var title: String
    private(set) var results: Results
    
    mutating func setTop(_ newTop: String, forPrecision: Precision) {
        switch forPrecision {
        case .edge:
            results.edge.top = newTop
        case .outer:
            results.outer.top = newTop
        case .middle:
            results.middle.top = newTop
        case .inner:
            results.inner.top = newTop
        case .bullsEye:
            results.bullsEye.top = newTop
        }
    }

    mutating func setBottom(_ newBottom: String?, forPrecision: Precision) {
        switch forPrecision {
        case .edge:
            results.edge.bottom = newBottom
        case .outer:
            results.outer.bottom = newBottom
        case .middle:
            results.middle.bottom = newBottom
        case .inner:
            results.inner.bottom = newBottom
        case .bullsEye:
            results.bullsEye.bottom = newBottom
        }
    }

    func result(forPrecision precision: Precision) -> Result {
        switch precision {
        case .edge:
            return results.edge
        case .outer:
            return results.outer
        case .middle:
            return results.middle
        case .inner:
            return results.inner
        case .bullsEye:
            return results.bullsEye
        }
    }
    init(index: Int, title: String, results: Results) {
        self.id = index
        self.title = title
        self.results = results
    }
    
    static func == (lhs: Theme, rhs: Theme) -> Bool {
        return lhs.id == rhs.id
    }
    
}
