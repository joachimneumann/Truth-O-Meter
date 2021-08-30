//
//  DiskParameter.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 30/08/2021.
//

import Foundation

class DiskParameters: Identifiable {
    var id = UUID()
    let precision: Precision
    var isGray: Bool
    
    init(_ precision: Precision) {
        self.precision = precision
        self.isGray = false
    }
}
