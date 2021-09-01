//
//  Settings.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 25/08/2021.
//

import Foundation

class Settings: ObservableObject {

    func result(forPrecision precision:  Precision) -> StampTexts {
        currentTheme.result(forPrecision: precision)
    }

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

    @Published private var privateCurrentTheme: Theme!
    
    var themes: [Theme] {
        [bullshit, truth, singing, custom]
    }

    var isCustomTheme: Bool {
        privateCurrentTheme == custom
    }

    var currentTheme:Theme {
        get { privateCurrentTheme }
        set {
            privateCurrentTheme = newValue
            UserDefaults.standard.setValue(newValue.id, forKey: C.key.selectedTheme)
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

    private var listenTiming: TimingEnum {
        if listenTimingIndex == 0 { return .fast }
        if listenTimingIndex == 1 { return .medium }
        return .slow
    }
    private var analysisTiming: TimingEnum {
        if analysisTimingIndex == 0 { return .fast }
        if analysisTimingIndex == 1 { return .medium }
        return .slow
    }

    private let bullshit = Theme(
        index: 0,
        title: "Bullshit-O-Meter",
        results: Results(
            edge:     StampTexts("Absolute", "Bullshit"),
            outer:    StampTexts("Bullshit", nil),
            middle:   StampTexts("undecided", nil),
            inner:    StampTexts("Mostly", "True"),
            bullsEye: StampTexts("True", nil)))

    private let truth = Theme(
        index: 1,
        title: "Truth-O-Meter",
        results: Results(
            edge:     StampTexts("True", nil),
            outer:    StampTexts("Mostly", "True"),
            middle:   StampTexts("undecided", nil),
            inner:    StampTexts("Bullshit", nil),
            bullsEye: StampTexts("Absolute", "Bullshit")))

    private let singing = Theme(
        index: 2,
        title: "Voice-O-Meter",
        results: Results(
            edge:     StampTexts("Sexy", nil),
            outer:    StampTexts("impressive", nil),
            middle:   StampTexts("good", nil),
            inner:    StampTexts("could be", "better"),
            bullsEye: StampTexts("flimsy", nil)))

    private var custom = Theme(
        index: 3,
        title: UserDefaults.standard.string(forKey: C.key.custom.title) ?? "",
        results: Results(
            edge:     StampTexts(UserDefaults.standard.string(forKey: C.key.custom.edge.top)     ?? "top",
                             UserDefaults.standard.string(forKey: C.key.custom.edge.bottom)      ?? "bottom"),
            outer:    StampTexts(UserDefaults.standard.string(forKey: C.key.custom.outer.top)    ?? "top",
                             UserDefaults.standard.string(forKey: C.key.custom.outer.bottom)     ?? "bottom"),
            middle:   StampTexts(UserDefaults.standard.string(forKey: C.key.custom.middle.top)   ?? "top",
                             UserDefaults.standard.string(forKey: C.key.custom.middle.bottom)    ?? "bottom"),
            inner:    StampTexts(UserDefaults.standard.string(forKey: C.key.custom.inner.top)    ?? "top",
                             UserDefaults.standard.string(forKey: C.key.custom.inner.bottom)     ?? "bottom"),
            bullsEye: StampTexts(UserDefaults.standard.string(forKey: C.key.custom.bullsEye.top) ?? "top",
                             UserDefaults.standard.string(forKey: C.key.custom.bullsEye.bottom)  ?? "bottom")),
        isCustomisable: true)



    func isCurrentTheme(_ themeInQuestion: Theme) -> Bool {
        return currentTheme == themeInQuestion
    }

    var listenTime: Double {
        listenTiming.time()
    }
    var analysisTime: Double {
        analysisTiming.time()
    }
    var listenAndAnalysisTime: Double {
        listenTime + analysisTime
    }

    init() {
        // Set currentTheme
        let index: Int = UserDefaults.standard.integer(forKey: C.key.selectedTheme)
        // This returns 0 if invalud or not set yet.
        // But this is what we want initially anyway (Bullshit-O-Meter)
        currentTheme = themes[index]
    }
}
