//
//  Settings.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 25/08/2021.
//

import Foundation

class Settings {
    private enum TimingEnum {
        case fast, medium, slow
    }

    private var listenTiming: TimingEnum = .fast
    private var analysisTiming: TimingEnum = .fast

    var listenTime: Double {
        switch listenTiming {
        case .slow:
            return 10.0
        case .medium:
            return 6.0
        case .fast:
            return 2.0
        }
    }
    
    var analysisTime: Double {
        switch analysisTiming {
        case .slow:
            return 10.0
        case .medium:
            return 6.0
        case .fast:
            return 2.0
        }
    }
    
    private let bullshitTheme = Theme(
        title: "Bullshit-O-Meter",
        results: [
            TapPrecision.bullsEye:      Result("True", nil),
            TapPrecision.inner:   Result("Mostly", "True"),
            TapPrecision.middle:  Result("undecided", nil),
            TapPrecision.outer:   Result("Bullshit", nil),
            TapPrecision.edge:    Result("Absolute", "Bullshit")
        ])
    
    private let truthTheme = Theme(
        title: "Truth-O-Meter",
        results: [
            TapPrecision.bullsEye:      Result("Absolute", "Bullshit"),
            TapPrecision.inner:   Result("Bullshit", nil),
            TapPrecision.middle:  Result("undecided", nil),
            TapPrecision.outer:   Result("Mostly", "True"),
            TapPrecision.edge:    Result("True", nil)
        ])

    private let singingTheme = Theme(
        title: "Voice-O-Meter",
        results: [
            TapPrecision.bullsEye:      Result("Sexy", nil),
            TapPrecision.inner:   Result("impressive", nil),
            TapPrecision.middle:  Result("good", nil),
            TapPrecision.outer:   Result("could be", "better"),
            TapPrecision.edge:    Result("flimsy", nil)
        ])
    
    var themes: [Theme] {
        [bullshitTheme, truthTheme, singingTheme]
    }
    private(set) var currentTheme:Theme

    
    var listenAndAnalysisTime: Double {
        get { listenTime + analysisTime }
    }
    
    init() {
        currentTheme = bullshitTheme
    }
}
