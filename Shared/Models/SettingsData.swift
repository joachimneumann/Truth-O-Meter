//
//  SettingsData.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 01/09/2021.
//

import Foundation

struct ThemeName: Identifiable {
    let id: Int
    let name: String
    let isCustom: Bool
}

struct SettingsData {
    
    mutating func setTop(top: String, forPrecision precision: Precision) {
        custom.setTop(top, forPrecision: precision)
    }
    mutating func setBottom(bottom: String?, forPrecision precision: Precision) {
        custom.setBottom(bottom, forPrecision: precision)
    }
    
    func stampBottom(forprecision precision: Precision) -> String? {
        seletedTheme.bottom(forPrecision: precision)
    }
    
    var selectedThemeIndex: Int {
        get { UserDefaults.standard.integer(forKey: C.key.selectedTheme) }
        set {
            UserDefaults.standard.setValue(newValue, forKey: C.key.selectedTheme)
        }
    }
    
    var themeNames: [ThemeName] {
        get {
            var ret = [ThemeName]()
            ret.append(ThemeName(id: 0, name: bullshit.title, isCustom: false))
            ret.append(ThemeName(id: 1, name: singing.title,  isCustom: false))
            ret.append(ThemeName(id: 2, name: custom.title, isCustom: true))
            return ret
        }
    }
    
    
    var seletedTheme: Theme {
        let s = selectedThemeIndex
        if s == 0 { return bullshit }
        if s == 1 { return singing }
        return custom
    }
    
    var title: String {
        seletedTheme.title
    }
    
    mutating func setTitle(_ newTitle: String) {
        custom.setTitle(newTitle)
    }
    
    let waitTimes = [2, 4, 10]
    var listenTime: Double {
        Double(waitTimes[listenTimingIndex])
    }
    
    let analysisTimes = [2, 4, 10]
    var analysisTime: Double {
        Double(waitTimes[analysisTimingIndex])
    }
    
    var listenTimingIndex: Int {
        get {
            if UserDefaults.standard.object(forKey: C.key.listenTiming) == nil {
                /// not set? use middle value of [0, 1, 2]
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
    
    private let bullshit = Theme(
        id: 0,
        title: "Bullshit-O-Meter",
        edge:     Theme.StampTexts("Absolute", "Bullshit"),
        outer:    Theme.StampTexts("Bullshit", nil),
        middle:   Theme.StampTexts("undecided", nil),
        inner:    Theme.StampTexts("Mostly", "True"),
        bullsEye: Theme.StampTexts("True", nil),
        isCustomisable: false)
    
    private let singing = Theme(
        id: 2,
        title: "Voice-O-Meter",
        edge:     Theme.StampTexts("Sexy", nil),
        outer:    Theme.StampTexts("impressive", nil),
        middle:   Theme.StampTexts("good", nil),
        inner:    Theme.StampTexts("could be", "better"),
        bullsEye: Theme.StampTexts("flimsy", nil),
        isCustomisable: false)
    
    private var custom = Theme(
        id: 3,
        title: UserDefaults.standard.string(forKey: C.key.custom.title) ?? "",
        edge:     Theme.StampTexts(UserDefaults.standard.string(forKey: C.key.custom.edge.top)     ?? "",
                                   UserDefaults.standard.string(forKey: C.key.custom.edge.bottom)      ?? ""),
        outer:    Theme.StampTexts(UserDefaults.standard.string(forKey: C.key.custom.outer.top)    ?? "",
                                   UserDefaults.standard.string(forKey: C.key.custom.outer.bottom)     ?? ""),
        middle:   Theme.StampTexts(UserDefaults.standard.string(forKey: C.key.custom.middle.top)   ?? "",
                                   UserDefaults.standard.string(forKey: C.key.custom.middle.bottom)    ?? ""),
        inner:    Theme.StampTexts(UserDefaults.standard.string(forKey: C.key.custom.inner.top)    ?? "",
                                   UserDefaults.standard.string(forKey: C.key.custom.inner.bottom)     ?? ""),
        bullsEye: Theme.StampTexts(UserDefaults.standard.string(forKey: C.key.custom.bullsEye.top) ?? "",
                                   UserDefaults.standard.string(forKey: C.key.custom.bullsEye.bottom)  ?? ""),
        isCustomisable: true)
    
}
