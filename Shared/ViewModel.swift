//
//  ViewModel.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 16/08/2021.
//

import Foundation
import SwiftUI

class ViewModel: ObservableObject {
    

    private      var model = Model()
    private(set) var needle = Needle()
    private(set) var settingsPrecision: TapPrecision = TapPrecision.middle
    private(set) var precision: TapPrecision = TapPrecision.middle

    @Published var settings = Settings()
    @Published var listeningProgress: CGFloat = 0.0
    @Published var analyseProgress: CGFloat = 0.0
    @Published var displayBackgroundColorful = false
        
    @Published var view: MainView.ViewEnum = .main

    // used in ModelDebugView
    var stateName: String {
        switch model.state {
        case .wait:
            return "wait"
        case .listen:
            return "listen"
        case .analyse:
            return "analyse"
        case .show:
            return "show"
        case .settings:
            return "settings"
        }
    }
       
    var customTop: String {
        get {
            if let r = settings.currentTheme.results[settingsPrecision] {
                return r.top
            } else {
                return ""
            }
        }
        set {
            if settings.currentTheme.results[settingsPrecision] != nil {
                settings.currentTheme.results[settingsPrecision]!.top = newValue
            }
        }
    }
    
    var customBottom: String {
        get {
            if let r = settings.currentTheme.results[settingsPrecision] {
                return r.bottom == nil ? "" : r.bottom!
            } else {
                return ""
            }
        }
        set {
            if settings.currentTheme.results[settingsPrecision] != nil {
                if newValue == "" {
                    settings.currentTheme.results[settingsPrecision]!.bottom = nil
                } else {
                    settings.currentTheme.results[settingsPrecision]!.bottom = newValue
                }
            }
        }
    }
    var customTitle: String {
        get {
            return settings.currentTheme.title
        }
        set {
            settings.currentTheme.title = newValue
        }
    }

    
    var stateIndex: Int { // for ModelDebugView
        get {
//            print("stateIndex getter")
            switch model.state {
            case .wait:
                return 0
            case .listen:
                return 1
            case .analyse:
                return 2
            case .show:
                return 3
            case .settings:
                return 4
            }
        }
        set{
//            print("stateIndex setter")
            switch newValue {
            case 0:
                setState(.wait)
            case 1:
                setState(.listen)
            case 2:
                setState(.analyse)
            case 3:
                setState(.show)
            case 4:
                setState(.settings)
            default:
                setState(.wait)
            }
        }
    }
    
    func setView(_ newView: MainView.ViewEnum) {
        if newView == .settings || newView == .detail {
            setState(.settings)
        } else {
            setState(.wait)
        }
        view = newView
        if newView == .detail {
            // load custom values?
            if settings.isCustomTheme {
                customTitle = UserDefaults.standard.string(forKey: C.UserDefaultKeys.customTitle) ?? ""
                settings.currentTheme.results[TapPrecision.edge]!.top =
                    UserDefaults.standard.string(forKey: C.UserDefaultKeys.customEdgeTop) ?? ""
                settings.currentTheme.results[TapPrecision.edge]!.bottom =
                    UserDefaults.standard.string(forKey: C.UserDefaultKeys.customEdgeBottom) ?? ""

                settings.currentTheme.results[TapPrecision.outer]!.top =
                    UserDefaults.standard.string(forKey: C.UserDefaultKeys.customOuterTop) ?? ""
                settings.currentTheme.results[TapPrecision.outer]!.bottom =
                    UserDefaults.standard.string(forKey: C.UserDefaultKeys.customOuterBottom) ?? ""
                settings.currentTheme.results[TapPrecision.middle]!.top =
                    UserDefaults.standard.string(forKey: C.UserDefaultKeys.customMiddleTop) ?? ""
                settings.currentTheme.results[TapPrecision.middle]!.bottom =
                    UserDefaults.standard.string(forKey: C.UserDefaultKeys.customMiddleBottom) ?? ""
                settings.currentTheme.results[TapPrecision.inner]!.top =
                    UserDefaults.standard.string(forKey: C.UserDefaultKeys.customInnerTop) ?? ""
                settings.currentTheme.results[TapPrecision.inner]!.bottom =
                    UserDefaults.standard.string(forKey: C.UserDefaultKeys.customInnerBottom) ?? ""
                settings.currentTheme.results[TapPrecision.bullsEye]!.top =
                    UserDefaults.standard.string(forKey: C.UserDefaultKeys.customBullsEyeTop) ?? ""
                settings.currentTheme.results[TapPrecision.bullsEye]!.bottom =
                    UserDefaults.standard.string(forKey: C.UserDefaultKeys.customBullsEyeBottom) ?? ""
            }
        }
    }
    
    func fromDetailViewToSettingsView() {
        if settings.isCustomTheme {
            saveCustom()
        }
        setView(.settings)
    }

    
    func saveCustom() {
        var b: String?
        UserDefaults.standard.set(
            customTitle,
            forKey: C.UserDefaultKeys.customTitle)
        UserDefaults.standard.set(
            settings.currentTheme.results[TapPrecision.edge]!.top,
            forKey: C.UserDefaultKeys.customEdgeTop)
        b = settings.currentTheme.results[TapPrecision.edge]!.bottom
        UserDefaults.standard.set(
            b == "" ? nil : b,
            forKey: C.UserDefaultKeys.customEdgeBottom)
        b = settings.currentTheme.results[TapPrecision.outer]!.top
        UserDefaults.standard.set(
            b == "" ? nil : b,
            forKey: C.UserDefaultKeys.customOuterTop)
        b = settings.currentTheme.results[TapPrecision.outer]!.bottom
        UserDefaults.standard.set(
            b == "" ? nil : b,
            forKey: C.UserDefaultKeys.customOuterBottom)
        b = settings.currentTheme.results[TapPrecision.middle]!.top
        UserDefaults.standard.set(
            b == "" ? nil : b,
            forKey: C.UserDefaultKeys.customMiddleTop)
        b = settings.currentTheme.results[TapPrecision.middle]!.bottom
        UserDefaults.standard.set(
            b == "" ? nil : b,
            forKey: C.UserDefaultKeys.customMiddleBottom)
        b = settings.currentTheme.results[TapPrecision.inner]!.top
        UserDefaults.standard.set(
            b == "" ? nil : b,
            forKey: C.UserDefaultKeys.customInnerTop)
        b = settings.currentTheme.results[TapPrecision.inner]!.bottom
        UserDefaults.standard.set(
            b == "" ? nil : b,
            forKey: C.UserDefaultKeys.customInnerBottom)
        b = settings.currentTheme.results[TapPrecision.bullsEye]!.top
        UserDefaults.standard.set(
            b == "" ? nil : b,
            forKey: C.UserDefaultKeys.customBullsEyeTop)
        b = settings.currentTheme.results[TapPrecision.bullsEye]!.bottom
        UserDefaults.standard.set(
            b == "" ? nil : b,
            forKey: C.UserDefaultKeys.customBullsEyeBottom)
    }
        
    var state: Model.State {
        get { model.state }
    }
        
    func settingsConfigutation(_ ring: TapPrecision) {
        setState(.settings)
        settingsPrecision = ring
        switch ring {
        case .bullsEye:
            needle.setValue(0.00)
        case .inner:
            needle.setValue(0.25)
        case .middle:
            needle.setValue(0.50)
        case .outer:
            needle.setValue(0.75)
        case .edge:
            needle.setValue(1.00)
        }
    }

    func tap(_ ring: TapPrecision) {
        print("tap(ring = \(ring))")
        precision = ring
        if state == .wait {
            setState(.listen)

            switch ring {
            case .bullsEye:
                needle.setValueInSteps(0.00, totalTime: settings.listenAndAnalysisTime)
            case .inner:
                needle.setValueInSteps(0.25, totalTime: settings.listenAndAnalysisTime)
            case .middle:
                needle.setValueInSteps(0.50, totalTime: settings.listenAndAnalysisTime)
            case .outer:
                needle.setValueInSteps(0.75, totalTime: settings.listenAndAnalysisTime)
            case .edge:
                needle.setValueInSteps(1.00, totalTime: settings.listenAndAnalysisTime)
            }
        } else if state == .settings {
            settingsConfigutation(ring)
        }
    }
    
    func setCurrentTheme(_ newTheme: Theme) {
        settings.setCurrentTheme(newTheme)
    }
    
    func setState(_ newState: Model.State) {
        model.setState(newState)

        // needle
        switch newState {
        case .wait:
            displayBackgroundColorful = false
            needle.active(false, strongNoise: false)
            needle.setValue(0.5)
        case .listen:
            displayBackgroundColorful = true
            needle.active(true, strongNoise: true)
        case .analyse:
            displayBackgroundColorful = true
            needle.active(true, strongNoise: false)
        case .show:
            displayBackgroundColorful = true
            needle.active(true, strongNoise: false)
        case .settings:
            displayBackgroundColorful = true
            needle.active(true, strongNoise: false)
        }
    }
    
}
