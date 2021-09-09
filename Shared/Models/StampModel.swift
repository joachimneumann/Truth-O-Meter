//
//  StampModel.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 09/09/2021.
//

import Foundation

class StampModel: ObservableObject {
    @Published var text: String = "text123"
    @Published var textSizeCaptured = false
    @Published var frameSizeCaptured = false
}
