//
//  Preferences.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 25/08/2021.
//

import Foundation
import SwiftUI

enum Precision {
    case edge, outer, middle, inner, bullsEye
}

class Preferences: ObservableObject {
    private var data = PreferencesData()
    
    var primaryColor:   Color = Color(white: 0.5)
    var secondaryColor: Color = Color(white: 0.5)
    var gray:           Color = Color(white: 0.5)
    var lightGray:      Color = Color(white: 0.5)

    var title: String {
        get {
            data.title
        }
        set {
            data.setTitle(newValue)
            objectWillChange.send()
        }
    }
    
    var isCustom: Bool { data.seletedTheme.isCustomisable }
    
    func stampTop(_ precision: Precision) -> String {
        data.seletedTheme.top(forPrecision: precision)
    }
    
//    var nonNilStampBottom: String {
//        /// needed for binding in TextField
//        get {
//            stampBottom ?? ""
//        }
//        set {
//            stampBottom = newValue == "" ? nil : newValue
//        }
//    }
    func stampBottom(_ precision: Precision) -> String? {
        data.seletedTheme.bottom(forPrecision: precision)
    }

    var selectedThemeIndex: Int {
        get { data.selectedThemeIndex }
        set {
            data.selectedThemeIndex = newValue
            objectWillChange.send()
        }
    }
    
    var themeNames: [ThemeName] { data.themeNames }

    var listenTimingIndex: Int {
        get { data.listenTimingIndex }
        set { data.listenTimingIndex = newValue }
    }
    var analysisTimingIndex: Int {
        get { data.analysisTimingIndex }
        set { data.analysisTimingIndex = newValue }
    }
    
    var listenTime: Double { data.listenTime }
    var analysisTime: Double { data.analysisTime }
    var listenAndAnalysisTime: Double { listenTime + analysisTime }

    var listenTimeStrings: [String] {
        get {
            var ret = [String]()
            ret.append("\(data.waitTimes[0]) sec")
            ret.append("\(data.waitTimes[1]) sec")
            ret.append("\(data.waitTimes[2]) sec")
            return ret
        }
    }
    var analysisTimeStrings: [String] {
        get {
            var ret = [String]()
            ret.append("\(data.analysisTimes[0]) sec")
            ret.append("\(data.analysisTimes[1]) sec")
            ret.append("\(data.analysisTimes[2]) sec")
            return ret
        }
    }
    
    func needleValue(forPrecision precision: Precision) -> Double {
        switch precision {
        case .bullsEye:
            return 0.00
        case .inner:
            return 0.25
        case .middle:
            return 0.50
        case .outer:
            return 0.75
        case .edge:
            return 1.00
        }
    }

    func setPreferredColorScheme(_ colorScheme: ColorScheme) {
        if colorScheme == .light {
            primaryColor = Color(red: 255.0/255.0, green: 83.0/255.0, blue: 77.0/255.0)
            secondaryColor = Color(red: 255.0/255.0, green: 220.0/255.0, blue: 218.0/255.0)
            gray = Color(red:  88/255.0, green: 89/255.0, blue: 82/255.0)
            lightGray = Color(red:  188/255.0, green: 189/255.0, blue: 182/255.0)
        } else {
            // dark
            primaryColor = Color(red: 242.0/255.0, green: 224.0/255.0, blue: 136.0/255.0)
            secondaryColor = Color(white: 0.7)
            gray = Color(white: 0.5)
            lightGray = Color(white: 0.7)
        }
    }
    
    init() {
        Needle.shared.setValue(needleValue(forPrecision: .middle))
    }
}
