//
//  Settings.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 25/08/2021.
//

import Foundation

struct Settings {
    enum TimingEnum {
        case fast, medium, slow
        func time() -> Double {
            switch self {
            case .fast:
                return 2.0
            case .medium:
                return 6.0
            case .slow:
                return 10.0
            }
        }
    }

    var listenTimingIndex: Int {
        get {
            if UserDefaults.standard.object(forKey: "listenTimingIndex") == nil {
                UserDefaults.standard.set(1, forKey: "listenTimingIndex")
            }
            return UserDefaults.standard.integer(forKey: "listenTimingIndex")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "listenTimingIndex")
        }
    }
    
    var analysisTimingIndex: Int {
        get {
            if UserDefaults.standard.object(forKey: "analysisTimingIndex") == nil {
                UserDefaults.standard.set(1, forKey: "analysisTimingIndex")
            }
            return UserDefaults.standard.integer(forKey: "analysisTimingIndex")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "analysisTimingIndex")
        }
    }

    var listenTiming: TimingEnum {
        if listenTimingIndex == 0 { return .fast }
        if listenTimingIndex == 1 { return .medium }
        return .slow
    }
    var analysisTiming: TimingEnum {
        if analysisTimingIndex == 0 { return .fast }
        if analysisTimingIndex == 1 { return .medium }
        return .slow
    }
    
    private let bullshitTheme = Theme(
        title: "Bullshit-O-Meter",
        results: [
            TapPrecision.bullsEye: Result("True", nil),
            TapPrecision.inner:    Result("Mostly", "True"),
            TapPrecision.middle:   Result("undecided", nil),
            TapPrecision.outer:    Result("Bullshit", nil),
            TapPrecision.edge:     Result("Absolute", "Bullshit")
        ])
    
    private let truthTheme = Theme(
        title: "Truth-O-Meter",
        results: [
            TapPrecision.bullsEye: Result("Absolute", "Bullshit"),
            TapPrecision.inner:    Result("Bullshit", nil),
            TapPrecision.middle:   Result("undecided", nil),
            TapPrecision.outer:    Result("Mostly", "True"),
            TapPrecision.edge:     Result("True", nil)
        ])

    private let singingTheme = Theme(
        title: "Voice-O-Meter",
        results: [
            TapPrecision.bullsEye: Result("flimsy", nil),
            TapPrecision.inner:    Result("could be", "better"),
            TapPrecision.middle:   Result("good", nil),
            TapPrecision.outer:    Result("impressive", nil),
            TapPrecision.edge:     Result("Sexy", nil)
        ])
    
    var themes: [Theme] {
        [bullshitTheme, truthTheme, singingTheme]
    }
    
    private(set) var currentTheme:Theme

    mutating func setCurrentTheme(_ newTheme: Theme) {
        currentTheme = newTheme
    }
    
    var listenAndAnalysisTime: Double {
        get { listenTiming.time() + analysisTiming.time() }
    }
    
    init() {
        currentTheme = bullshitTheme
    }
}
