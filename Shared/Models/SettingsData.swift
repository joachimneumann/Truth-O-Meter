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
    
    init() {
        selectedThemeIndex = 0//UserDefaults.standard.integer(forKey: C.key.selectedTheme)
    }
    
    func stampTop(forprecision precision: Precision) -> String {
        seletedTheme.top(forPrecision: precision)
    }
    
    func stampBottom(forprecision precision: Precision) -> String? {
        seletedTheme.bottom(forPrecision: precision)
    }
    
    var selectedThemeIndex = 0
    
    var themeNames: [ThemeName] {
        get {
            var ret = [ThemeName]()
            ret.append(ThemeName(id: 0, name: bullshit.title, isCustom: false))
            ret.append(ThemeName(id: 1, name: truth.title,    isCustom: false))
            ret.append(ThemeName(id: 2, name: singing.title,  isCustom: false))
            ret.append(ThemeName(id: 3, name: bullshit.title, isCustom: true))
            return ret
        }
    }

    
    var seletedTheme: Theme {
        if selectedThemeIndex == 0 { return bullshit }
        if selectedThemeIndex == 1 { return truth }
        if selectedThemeIndex == 2 { return singing }
        return custom
    }
    
    var title: String {
        seletedTheme.title
    }
    
    mutating func setTitle(_ newTitle: String) {
        custom.setTitle(newTitle)
    }

    let listenTimes = [2, 4, 10]
    var listenTime: Double {
        Double(listenTimes[listenTimingIndex])
    }

    let analysisTimes = [2, 4, 10]
    var analysisTime: Double {
        Double(listenTimes[analysisTimingIndex])
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
    
    private let bullshit = Theme(
        id: 0,
        title: "Bullshit-O-Meter",
        edge:     Theme.StampTexts("Absolute", "Bullshit"),
        outer:    Theme.StampTexts("Bullshit", nil),
        middle:   Theme.StampTexts("undecided", nil),
        inner:    Theme.StampTexts("Mostly", "True"),
        bullsEye: Theme.StampTexts("True", nil),
        isCustomisable: false)

    private let truth = Theme(
        id: 1,
        title: "Truth-O-Meter",
        edge:     Theme.StampTexts("True", nil),
        outer:    Theme.StampTexts("Mostly", "True"),
        middle:   Theme.StampTexts("undecided", nil),
        inner:    Theme.StampTexts("Bullshit", nil),
        bullsEye: Theme.StampTexts("Absolute", "Bullshit"),
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
        title: "",
        edge:     Theme.StampTexts("", ""),
        outer:    Theme.StampTexts("", ""),
        middle:   Theme.StampTexts("", ""),
        inner:    Theme.StampTexts("", ""),
        bullsEye: Theme.StampTexts("", ""),
        isCustomisable: false)
}
