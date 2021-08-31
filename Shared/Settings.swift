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
            if UserDefaults.standard.object(forKey: C.key.listenTiming) == nil {
                UserDefaults.standard.set(1, forKey: C.key.listenTiming)
            }
            return UserDefaults.standard.integer(forKey: C.key.listenTiming)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: C.key.listenTiming)
        }
    }
    
    var analysisTimingIndex: Int {
        get {
            if UserDefaults.standard.object(forKey: C.key.analysisTiming) == nil {
                UserDefaults.standard.set(1, forKey: C.key.analysisTiming)
            }
            return UserDefaults.standard.integer(forKey: C.key.analysisTiming)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: C.key.analysisTiming)
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
        results: Results(
            edge:     Result("Absolute", "Bullshit"),
            outer:    Result("Bullshit", nil),
            middle:   Result("undecided", nil),
            inner:    Result("Mostly", "True"),
            bullsEye: Result("True", nil)))

    private let truth = Theme(
        index: 1,
        title: "Truth-O-Meter",
        results: Results(
            edge:     Result("True", nil),
            outer:    Result("Mostly", "True"),
            middle:   Result("undecided", nil),
            inner:    Result("Bullshit", nil),
            bullsEye: Result("Absolute", "Bullshit")))
    
    private let singing = Theme(
        index: 2,
        title: "Voice-O-Meter",
        results: Results(
            edge:     Result("Sexy", nil),
            outer:    Result("impressive", nil),
            middle:   Result("good", nil),
            inner:    Result("could be", "better"),
            bullsEye: Result("flimsy", nil)))

    private var custom = Theme(
        index: 3,
        title: "",
        results: Results(
            edge:     Result("", ""),
            outer:    Result("", ""),
            middle:   Result("", ""),
            inner:    Result("", ""),
            bullsEye: Result("", "")))
   
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
        UserDefaults.standard.setValue(newTheme.id, forKey: C.key.selectedTheme)
        currentTheme = newTheme
    }
    
    var listenAndAnalysisTime: Double {
        get { listenTiming.time() + analysisTiming.time() }
    }
    
    init() {
        if let s = UserDefaults.standard.string(forKey: C.key.custom.title) {
            custom.title = s
        }
        if let s = UserDefaults.standard.string(forKey: C.key.custom.edge.top) {
            custom.setTop(s, forPrecision: .edge)
        }
        if let s = UserDefaults.standard.string(forKey: C.key.custom.edge.bottom) {
            custom.setBottom(s, forPrecision: .edge)
        }
        if let s = UserDefaults.standard.string(forKey: C.key.custom.outer.top) {
            custom.setTop(s, forPrecision: .outer)
        }
        if let s = UserDefaults.standard.string(forKey: C.key.custom.outer.bottom) {
            custom.setBottom(s, forPrecision: .outer)
        }
        if let s = UserDefaults.standard.string(forKey: C.key.custom.middle.top) {
            custom.setTop(s, forPrecision: .middle)
        }
        if let s = UserDefaults.standard.string(forKey: C.key.custom.middle.bottom) {
            custom.setBottom(s, forPrecision: .middle)
        }
        if let s = UserDefaults.standard.string(forKey: C.key.custom.inner.top) {
            custom.setTop(s, forPrecision: .inner)
        }
        if let s = UserDefaults.standard.string(forKey: C.key.custom.inner.bottom) {
            custom.setBottom(s, forPrecision: .inner)
        }
        if let s = UserDefaults.standard.string(forKey: C.key.custom.bullsEye.top) {
            custom.setTop(s, forPrecision: .bullsEye)
        }
        if let s = UserDefaults.standard.string(forKey: C.key.custom.bullsEye.bottom) {
            custom.setBottom(s, forPrecision: .bullsEye)
        }


        // last Step: set currentTheme
        let index: Int = 0//UserDefaults.standard.integer(forKey: C.key.selectedTheme)
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
    }
}
