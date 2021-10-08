//
//  PreferencesData.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 01/09/2021.
//

import Foundation
import SwiftUI

struct Key {
    /// some key names might seem stange, but this is
    /// for compatibility with older app versions
    static let listenTiming         = "fastResponseTimeKey"
    static let analysisTiming       = "analysisTimingIndexkey"
    static let selectedTheme        = "selectedTheme"
    struct custom {
        static let title          = "CustomiseddisplayTextkey"
        struct edge {
            static let top        = "CustomisedfarLeftText1key"
            static let bottom     = "CustomisedfarLeftText2key"
        }
        struct outer {
            static let top       = "CustomisedleftText1key"
            static let bottom    = "CustomisedleftText2key"
        }
        struct middle {
            static let top      = "CustomisedcenterText1key"
            static let bottom   = "CustomisedcenterText2key"
        }
        struct inner {
            static let top       = "CustomisedrightText1key"
            static let bottom    = "CustomisedrightText2key"
        }
        struct bullsEye {
            static let top    = "CustomisedfarRightText1key"
            static let bottom = "CustomisedfarRightText2key"
        }
    }
}

struct Theme: Identifiable, Equatable {

    private(set) var id: Int

    var title: String = ""

    mutating func setTop(top: String, forPrecision precision: Precision) {
        switch precision {
        case .edge:
            edge.top = top
        case .outer:
            outer.top = top
        case .middle:
            middle.top = top
        case .inner:
            inner.top = top
        case .bullsEye:
            bullsEye.top = top
        }
    }
    mutating func setBottom(bottom: String, forPrecision precision: Precision) {
        switch precision {
        case .edge:
            edge.bottom = bottom
        case .outer:
            outer.bottom = bottom
        case .middle:
            middle.bottom = bottom
        case .inner:
            inner.bottom = bottom
        case .bullsEye:
            bullsEye.bottom = bottom
        }
    }
    
    func top(forPrecision precision: Precision) -> String {
        switch precision {
        case .edge:
            return edge.top
        case .outer:
            return outer.top
        case .middle:
            return middle.top
        case .inner:
            return inner.top
        case .bullsEye:
            return bullsEye.top
        }
    }
    
    func bottom(forPrecision precision: Precision) -> String? {
        switch precision {
        case .edge:
            return edge.bottom
        case .outer:
            return outer.bottom
        case .middle:
            return middle.bottom
        case .inner:
            return inner.bottom
        case .bullsEye:
            return bullsEye.bottom
        }
    }

    
    struct StampTexts {
        var top: String
        var bottom: String
        init(_ top_: String, _ bottom_: String) { top = top_; bottom = bottom_ }
    }

    var edge: StampTexts
    var outer: StampTexts
    var middle: StampTexts
    var inner: StampTexts
    var bullsEye: StampTexts
    var isCustomisable: Bool

    mutating func setTop(_ newTop: String, forPrecision: Precision) {
        switch forPrecision {
        case .edge:
            edge.top = newTop
            if isCustomisable { PreferencesData.customEdgeTop = newTop }
        case .outer:
            outer.top = newTop
            if isCustomisable { PreferencesData.customOuterTop = newTop }
        case .middle:
            middle.top = newTop
            if isCustomisable { PreferencesData.customMiddleTop = newTop }
        case .inner:
            inner.top = newTop
            if isCustomisable { PreferencesData.customInnerTop = newTop }
        case .bullsEye:
            bullsEye.top = newTop
            if isCustomisable { PreferencesData.customBullsEyeTop = newTop }
        }
    }
    
    mutating func setBottom(_ newBottom: String, forPrecision: Precision) {
        switch forPrecision {
        case .edge:
            edge.bottom = newBottom
            if isCustomisable { PreferencesData.customEdgeBottom = newBottom }
        case .outer:
            outer.bottom = newBottom
            if isCustomisable { PreferencesData.customOuterBottom = newBottom }
        case .middle:
            middle.bottom = newBottom
            if isCustomisable { PreferencesData.customMiddleBottom = newBottom }
        case .inner:
            inner.bottom = newBottom
            if isCustomisable { PreferencesData.customInnerBottom = newBottom }
        case .bullsEye:
            bullsEye.bottom = newBottom
            if isCustomisable { PreferencesData.customBullsEyeBottom = newBottom }
        }
    }

    static func == (lhs: Theme, rhs: Theme) -> Bool {
        return lhs.id == rhs.id
    }
    
}

struct ThemeName: Identifiable {
    let id: Int
    let name: String
    let isCustom: Bool
}

struct PreferencesData {

    @AppStorage("listenTimingIndex")    static var listenTimingIndex: Int = 1
    @AppStorage("analysisTimingIndex")  static var analysisTimingIndex: Int = 1
    @AppStorage("customTitle")          static var customTitle: String = ""
    @AppStorage("customEdgeTop")        static var customEdgeTop = ""
    @AppStorage("customEdgeBottom")     static var customEdgeBottom = ""
    @AppStorage("customOuterTop")       static var customOuterTop = ""
    @AppStorage("customOuterBottom")    static var customOuterBottom = ""
    @AppStorage("customMiddleTop")      static var customMiddleTop = ""
    @AppStorage("customMiddleBottom")   static var customMiddleBottom = ""
    @AppStorage("customInnerTop")       static var customInnerTop = ""
    @AppStorage("customInnerBottom")    static var customInnerBottom = ""
    @AppStorage("customBullsEyeTop")    static var customBullsEyeTop = ""
    @AppStorage("customBullsEyeBottom") static var customBullsEyeBottom = ""
    @AppStorage("selectedThemeIndex")   static var selectedThemeIndex: Int = 1
    

    mutating func setTop(top: String, forPrecision precision: Precision) {
        custom.setTop(top, forPrecision: precision)
    }
    mutating func setBottom(bottom: String, forPrecision precision: Precision) {
        custom.setBottom(bottom, forPrecision: precision)
    }
    
    func stampBottom(forprecision precision: Precision) -> String? {
        seletedTheme.bottom(forPrecision: precision)
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
        let s = PreferencesData.selectedThemeIndex
        if s == 0 { return bullshit }
        if s == 1 { return singing }
        return custom
    }
    
    var title: String {
        seletedTheme.title
    }
    
    mutating func setTitle(_ newTitle: String) {
        custom.title = newTitle
    }
    
    let waitTimes = [2, 4, 10]
    var listenTime: Double {
        Double(waitTimes[PreferencesData.listenTimingIndex])
    }
    
    let analysisTimes = [2, 4, 10]
    var analysisTime: Double {
        Double(waitTimes[PreferencesData.analysisTimingIndex])
    }
    
    private let bullshit = Theme(
        id: 0,
        title: "Bullshit-O-Meter",
        edge:     Theme.StampTexts("Absolute", "Bullshit"),
        outer:    Theme.StampTexts("Bullshit", ""),
        middle:   Theme.StampTexts("undecided", ""),
        inner:    Theme.StampTexts("Mostly", "True"),
        bullsEye: Theme.StampTexts("True", ""),
        isCustomisable: false)
    
    private let singing = Theme(
        id: 2,
        title: "Voice-O-Meter",
        edge:     Theme.StampTexts("Sexy", ""),
        outer:    Theme.StampTexts("impressive", ""),
        middle:   Theme.StampTexts("good", ""),
        inner:    Theme.StampTexts("could be", "better"),
        bullsEye: Theme.StampTexts("flimsy", ""),
        isCustomisable: false)
    

    private var
    custom = Theme(
                id: 3,
                title:    PreferencesData.customTitle,
                edge:     Theme.StampTexts(PreferencesData.customEdgeTop,     PreferencesData.customEdgeBottom),
                outer:    Theme.StampTexts(PreferencesData.customOuterTop,    PreferencesData.customOuterBottom),
                middle:   Theme.StampTexts(PreferencesData.customMiddleTop,   PreferencesData.customMiddleBottom),
                inner:    Theme.StampTexts(PreferencesData.customInnerTop,    PreferencesData.customInnerBottom),
                bullsEye: Theme.StampTexts(PreferencesData.customBullsEyeTop, PreferencesData.customBullsEyeBottom),
                isCustomisable: true)
}
