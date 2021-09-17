//
//  PreferencesData.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 01/09/2021.
//

import Foundation


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

    var title: String {
        didSet {
            UserDefaults.standard.set(title, forKey: Key.custom.title)
        }
    }
    
    mutating func setTitle(_ newTitle: String) {
        title = newTitle
    }

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
    mutating func setBottom(bottom: String?, forPrecision precision: Precision) {
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
        var bottom: String?
        init(_ top_: String, _ bottom_: String?) { top = top_; bottom = bottom_ }
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
            if isCustomisable { UserDefaults.standard.set(newTop, forKey: Key.custom.edge.top) }
        case .outer:
            outer.top = newTop
            if isCustomisable { UserDefaults.standard.set(newTop, forKey: Key.custom.outer.top) }
        case .middle:
            middle.top = newTop
            if isCustomisable { UserDefaults.standard.set(newTop, forKey: Key.custom.middle.top) }
        case .inner:
            inner.top = newTop
            if isCustomisable { UserDefaults.standard.set(newTop, forKey: Key.custom.inner.top) }
        case .bullsEye:
            bullsEye.top = newTop
            if isCustomisable { UserDefaults.standard.set(newTop, forKey: Key.custom.bullsEye.top) }
        }
    }
    
    mutating func setBottom(_ newBottom: String?, forPrecision: Precision) {
        switch forPrecision {
        case .edge:
            edge.bottom = newBottom
            if isCustomisable { UserDefaults.standard.set(newBottom, forKey: Key.custom.edge.bottom) }
        case .outer:
            outer.bottom = newBottom
            if isCustomisable { UserDefaults.standard.set(newBottom, forKey: Key.custom.outer.bottom) }
        case .middle:
            middle.bottom = newBottom
            if isCustomisable { UserDefaults.standard.set(newBottom, forKey: Key.custom.middle.bottom) }
        case .inner:
            inner.bottom = newBottom
            if isCustomisable { UserDefaults.standard.set(newBottom, forKey: Key.custom.inner.bottom) }
        case .bullsEye:
            bullsEye.bottom = newBottom
            if isCustomisable { UserDefaults.standard.set(newBottom, forKey: Key.custom.bullsEye.bottom) }
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
        get { UserDefaults.standard.integer(forKey: Key.selectedTheme) }
        set {
            UserDefaults.standard.setValue(newValue, forKey: Key.selectedTheme)
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
            if UserDefaults.standard.object(forKey: Key.listenTiming) == nil {
                /// not set? use middle value of [0, 1, 2]
                UserDefaults.standard.set(1, forKey: Key.listenTiming)
            }
            return UserDefaults.standard.integer(forKey: Key.listenTiming)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Key.listenTiming)
        }
    }
    
    var analysisTimingIndex: Int {
        get {
            if UserDefaults.standard.object(forKey: Key.analysisTiming) == nil {
                UserDefaults.standard.set(1, forKey: Key.analysisTiming)
            }
            return UserDefaults.standard.integer(forKey: Key.analysisTiming)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Key.analysisTiming)
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
        title: UserDefaults.standard.string(forKey: Key.custom.title) ?? "",
        edge:     Theme.StampTexts(UserDefaults.standard.string(forKey: Key.custom.edge.top)     ?? "",
                                   UserDefaults.standard.string(forKey: Key.custom.edge.bottom)      ?? ""),
        outer:    Theme.StampTexts(UserDefaults.standard.string(forKey: Key.custom.outer.top)    ?? "",
                                   UserDefaults.standard.string(forKey: Key.custom.outer.bottom)     ?? ""),
        middle:   Theme.StampTexts(UserDefaults.standard.string(forKey: Key.custom.middle.top)   ?? "",
                                   UserDefaults.standard.string(forKey: Key.custom.middle.bottom)    ?? ""),
        inner:    Theme.StampTexts(UserDefaults.standard.string(forKey: Key.custom.inner.top)    ?? "",
                                   UserDefaults.standard.string(forKey: Key.custom.inner.bottom)     ?? ""),
        bullsEye: Theme.StampTexts(UserDefaults.standard.string(forKey: Key.custom.bullsEye.top) ?? "",
                                   UserDefaults.standard.string(forKey: Key.custom.bullsEye.bottom)  ?? ""),
        isCustomisable: true)
    
}
