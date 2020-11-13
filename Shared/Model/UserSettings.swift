//
//  UserSettings.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 11/12/20.
//

import SwiftUI

class UserSettings: ObservableObject {
    @Published var title = "Truth-O-Meter"
    @Published var question = "Is that true?"
    @Published var width: CGFloat = 100.0 {
        didSet {
            print("UserSettings: newValue = \(width)")
        }
    }
}
