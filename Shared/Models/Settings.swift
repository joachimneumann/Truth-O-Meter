//
//  Settings.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 25/08/2021.
//

import Foundation

class Settings: ObservableObject {
    private var settingsData = SettingsData()
    
    var precision: Precision {
        didSet {
            objectWillChange.send()
            print("Settings gray send()")
        }
    }
    var title: String {
        get {
            settingsData.title
        }
        set {
            settingsData.setTitle(newValue)
            objectWillChange.send()
            print("Settings title send()")
        }
    }
    
    var isCustom: Bool {
        settingsData.seletedTheme.isCustomisable
    }
    
    var stampTop: String {
        get {
            settingsData.seletedTheme.top(forPrecision: precision)
        }
        set {
            settingsData.setTop(top: newValue, forPrecision: precision)
            objectWillChange.send()
            print("Settings stampTop send()")
        }
    }
    
    var stampBottom: String {
        get {
            settingsData.seletedTheme.bottom(forPrecision: precision) ?? ""
        }
        set {
            if newValue == "" {
                settingsData.setBottom(bottom: nil, forPrecision: precision)
            } else {
                settingsData.setBottom(bottom: newValue, forPrecision: precision)
            }
            objectWillChange.send()
            print("Settings stampBottom send()")
        }
    }

    var selectedThemeIndex: Int {
        get {
            settingsData.selectedThemeIndex
        }
        set {
            settingsData.selectedThemeIndex = newValue
            objectWillChange.send()
            print("Settings themeIndex send()")
        }
    }
    var themeNames: [ThemeName] {
        settingsData.themeNames
    }

    var listenTimingIndex: Int
    var analysisTimingIndex: Int = 0
    
    var listenTime: Double {
        settingsData.listenTime
    }
    var analysisTime: Double {
        settingsData.analysisTime
    }
    var listenAndAnalysisTime: Double {
        listenTime + analysisTime
    }

    var listenTimeStrings: [String] {
        get {
            var ret = [String]()
            ret.append("\(settingsData.listenTimes[0]) sec")
            ret.append("\(settingsData.listenTimes[1]) sec")
            ret.append("\(settingsData.listenTimes[2]) sec")
            return ret
        }
    }
    var analysisTimeStrings: [String] {
        get {
            var ret = [String]()
            ret.append("\(settingsData.analysisTimes[0]) sec")
            ret.append("\(settingsData.analysisTimes[1]) sec")
            ret.append("\(settingsData.analysisTimes[2]) sec")
            return ret
        }
    }

    init() {
        listenTimingIndex = settingsData.listenTimingIndex
        analysisTimingIndex = settingsData.analysisTimingIndex
        precision = .middle
    }
    
    /*
    func stampTexts(forPrecision precision:  Precision) -> StampTexts {
        currentTheme.stampTexts(forPrecision: precision)
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

    init() {
        // Set currentTheme
        let index: Int = UserDefaults.standard.integer(forKey: C.key.selectedTheme)
        // This returns 0 if invalud or not set yet.
        // But this is what we want initially anyway (Bullshit-O-Meter)
        currentTheme = themes[index]
    }
 */
}
