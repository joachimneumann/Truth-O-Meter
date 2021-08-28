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
            if UserDefaults.standard.object(forKey: C.Key.listenTiming) == nil {
                UserDefaults.standard.set(1, forKey: C.Key.listenTiming)
            }
            return UserDefaults.standard.integer(forKey: C.Key.listenTiming)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: C.Key.listenTiming)
        }
    }
    
    var analysisTimingIndex: Int {
        get {
            if UserDefaults.standard.object(forKey: C.Key.analysisTiming) == nil {
                UserDefaults.standard.set(1, forKey: C.Key.analysisTiming)
            }
            return UserDefaults.standard.integer(forKey: C.Key.analysisTiming)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: C.Key.analysisTiming)
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
    
    private let bullshit = Theme(
        index: 0,
        title: "Bullshit-O-Meter",
        results: [
            TapPrecision.bullsEye: Result("True", nil),
            TapPrecision.inner:    Result("Mostly", "True"),
            TapPrecision.middle:   Result("undecided", nil),
            TapPrecision.outer:    Result("Bullshit", nil),
            TapPrecision.edge:     Result("Absolute", "Bullshit")
        ])
    
    private let truth = Theme(
        index: 1,
        title: "Truth-O-Meter",
        results: [
            TapPrecision.bullsEye: Result("Absolute", "Bullshit"),
            TapPrecision.inner:    Result("Bullshit", nil),
            TapPrecision.middle:   Result("undecided", nil),
            TapPrecision.outer:    Result("Mostly", "True"),
            TapPrecision.edge:     Result("True", nil)
        ])

    private let singing = Theme(
        index: 2,
        title: "Voice-O-Meter",
        results: [
            TapPrecision.bullsEye: Result("flimsy", nil),
            TapPrecision.inner:    Result("could be", "better"),
            TapPrecision.middle:   Result("good", nil),
            TapPrecision.outer:    Result("impressive", nil),
            TapPrecision.edge:     Result("Sexy", nil)
        ])

    private var custom = Theme(
        index: 3,
        title: "",
        results: [
            TapPrecision.bullsEye: Result("", ""),
            TapPrecision.inner:    Result("", ""),
            TapPrecision.middle:   Result("", ""),
            TapPrecision.outer:    Result("", ""),
            TapPrecision.edge:     Result("", "")
        ])
    
    mutating func updateCustom(t: String) {
        custom.title = t
    }
    
    
    var themes: [Theme] {
        [bullshit, truth, singing, custom]
    }
    
    var isCustomTheme: Bool {
        currentTheme == custom
    }
    
    var currentTheme:Theme

    mutating func setCurrentTheme(_ newTheme: Theme) {
        UserDefaults.standard.setValue(newTheme.id, forKey: C.Key.selectedTheme)
        currentTheme = newTheme
    }
    
    var listenAndAnalysisTime: Double {
        get { listenTiming.time() + analysisTiming.time() }
    }
    
    init() {
        let index: Int = UserDefaults.standard.integer(forKey: C.Key.selectedTheme)
        // This returns 0 if invalud or not set yet.
        // But this is what we want initially anyway (Bullshit-O-Meter)
        
        // currentTheme = themes[index]
        // --> compiler error !?!

        // work-around:
        if index == 0 { currentTheme = bullshit }
        else if index == 1 { currentTheme = truth }
        else if index == 2 { currentTheme = singing }
        else if index == 3 { currentTheme = custom }
        else { currentTheme = bullshit }
        
        if let s = UserDefaults.standard.string(forKey: C.Key.customTitle) {
            custom.title = s
        }
    }
}
