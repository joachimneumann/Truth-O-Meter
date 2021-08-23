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
struct Theme {
    let displayText: String
    let farRight: Result
    let right:    Result
    let center:   Result
    let left:     Result
    let farLeft:  Result
}
