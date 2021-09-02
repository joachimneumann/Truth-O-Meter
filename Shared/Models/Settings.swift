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
    
    var nonNilStampBottom: String {
        get {
            stampBottom ?? ""
        }
        set {
            stampBottom = newValue == "" ? nil : newValue
        }
    }
    var stampBottom: String? {
        get {
            settingsData.seletedTheme.bottom(forPrecision: precision)
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

    var listenTimingIndex: Int {
        get {
            settingsData.listenTimingIndex
        }
        set {
            settingsData.listenTimingIndex = newValue
        }
    }
    var analysisTimingIndex: Int {
        get {
            settingsData.analysisTimingIndex
        }
        set {
            settingsData.analysisTimingIndex = newValue
        }
    }
    
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
            ret.append("\(settingsData.waitTimes[0]) sec")
            ret.append("\(settingsData.waitTimes[1]) sec")
            ret.append("\(settingsData.waitTimes[2]) sec")
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
        precision = .middle
    }
}
