//
//  ViewModel.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 16/08/2021.
//

import Foundation
import SwiftUI

class ViewModel: ObservableObject {
    @Published var isListening = false

    func endOfListening() {
        isListening = false
    }

    func pressed(precision: Precision) {
//        isListening = true
//        switch precision {
//        case .bullsEye:
//            needle.setValueInSteps(0.00, totalTime: settings.listenAndAnalysisTime)
//        case .inner:
//            needle.setValueInSteps(0.25, totalTime: settings.listenAndAnalysisTime)
//        case .middle:
//            needle.setValueInSteps(0.50, totalTime: settings.listenAndAnalysisTime)
//        case .outer:
//            needle.setValueInSteps(0.75, totalTime: settings.listenAndAnalysisTime)
//        case .edge:
//            needle.setValueInSteps(1.00, totalTime: settings.listenAndAnalysisTime)
//        }
    }
    
    
    private      var model = Model()
//    private(set) var settingsPrecision: Precision = Precision.middle
//    private(set) var precision: Precision = Precision.middle

    @Published var settings = Settings()
    @Published var listeningProgress: CGFloat = 0.0
    @Published var analyseProgress: CGFloat = 0.0
    @Published var displayBackgroundColorful = false
        
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
       
//    var customTop: String {
//        get {
//            settings.currentTheme.result(precision: settingsPrecision).top
//        }
//        set {
//            settings.currentTheme.setTop(newValue, forPrecision: settingsPrecision)
//        }
//    }
//
//    var customBottom: String {
//        get {
//            settings.currentTheme.result(precision: settingsPrecision).bottom ?? ""
//        }
//        set {
//            let s: String? = newValue == "" ? nil : newValue
//            settings.currentTheme.setBottom(s, forPrecision: settingsPrecision)
//        }
//    }
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
    
//    func setView(_ newView: MainView.ViewEnum) {
//        if newView == .settings || newView == .detail {
//            setState(.settings)
//        } else {
//            setState(.wait)
//        }
//        view = newView
//        if newView == .detail {
//            // load custom values
//            if settings.isCustomTheme {
//                var s: String
//                customTitle = UserDefaults.standard.string(forKey: C.key.custom.title) ?? ""
//
//                s = UserDefaults.standard.string(forKey: C.key.custom.edge.top) ?? ""
//                settings.currentTheme.setTop(s, forPrecision: .edge)
//                s = UserDefaults.standard.string(forKey: C.key.custom.edge.bottom) ?? ""
//                settings.currentTheme.setBottom(s, forPrecision: .edge)
//                s = UserDefaults.standard.string(forKey: C.key.custom.outer.top) ?? ""
//                settings.currentTheme.setTop(s, forPrecision: .outer)
//                s = UserDefaults.standard.string(forKey: C.key.custom.outer.bottom) ?? ""
//                settings.currentTheme.setBottom(s, forPrecision: .outer)
//                s = UserDefaults.standard.string(forKey: C.key.custom.middle.top) ?? ""
//                settings.currentTheme.setTop(s, forPrecision: .middle)
//                s = UserDefaults.standard.string(forKey: C.key.custom.middle.bottom) ?? ""
//                settings.currentTheme.setBottom(s, forPrecision: .middle)
//                s = UserDefaults.standard.string(forKey: C.key.custom.inner.top) ?? ""
//                settings.currentTheme.setTop(s, forPrecision: .inner)
//                s = UserDefaults.standard.string(forKey: C.key.custom.inner.bottom) ?? ""
//                settings.currentTheme.setBottom(s, forPrecision: .inner)
//                s = UserDefaults.standard.string(forKey: C.key.custom.bullsEye.top) ?? ""
//                settings.currentTheme.setTop(s, forPrecision: .bullsEye)
//                s = UserDefaults.standard.string(forKey: C.key.custom.bullsEye.bottom) ?? ""
//                settings.currentTheme.setBottom(s, forPrecision: .bullsEye)
//            }
//        }
//    }

//    func fromSettingsViewToMainView() {
//        // the theme has already been set inside SettingsView
//        setView(.main)
//    }
//
//    func fromDetailViewToSettingsView() {
//        if settings.isCustomTheme {
//            saveCustom()
//        }
//        setView(.settings)
//    }

    
    func saveCustom() {
        UserDefaults.standard.set(
            customTitle,
            forKey: C.key.custom.title)
        UserDefaults.standard.set(
            settings.currentTheme.results.edge.top,
            forKey: C.key.custom.edge.top)
        UserDefaults.standard.set(
            settings.currentTheme.results.edge.bottom,
            forKey: C.key.custom.edge.bottom)
        UserDefaults.standard.set(
            settings.currentTheme.results.outer.top,
            forKey: C.key.custom.outer.top)
        UserDefaults.standard.set(
            settings.currentTheme.results.outer.bottom,
            forKey: C.key.custom.outer.bottom)
        UserDefaults.standard.set(
            settings.currentTheme.results.middle.top,
            forKey: C.key.custom.middle.top)
        UserDefaults.standard.set(
            settings.currentTheme.results.middle.bottom,
            forKey: C.key.custom.middle.bottom)
        UserDefaults.standard.set(
            settings.currentTheme.results.inner.top,
            forKey: C.key.custom.inner.top)
        UserDefaults.standard.set(
            settings.currentTheme.results.inner.bottom,
            forKey: C.key.custom.inner.bottom)
        UserDefaults.standard.set(
            settings.currentTheme.results.bullsEye.top,
            forKey: C.key.custom.bullsEye.top)
        UserDefaults.standard.set(
            settings.currentTheme.results.bullsEye.bottom,
            forKey: C.key.custom.bullsEye.bottom)
    }
        
    
    var state: Model.State {
        get { model.state }
    }
        
    
    var isSettingsState: Bool {
        state == .settings
    }

    func tap(_ newPrecision: Precision) {
//        print("tap(precision = \(newPrecision))")
////        precision = newPrecision
//        if state == .wait {
////            setState(.listen)
//
//            switch newPrecision {
//            case .bullsEye:
//                needle.setValueInSteps(0.00, totalTime: settings.listenAndAnalysisTime)
//            case .inner:
//                needle.setValueInSteps(0.25, totalTime: settings.listenAndAnalysisTime)
//            case .middle:
//                needle.setValueInSteps(0.50, totalTime: settings.listenAndAnalysisTime)
//            case .outer:
//                needle.setValueInSteps(0.75, totalTime: settings.listenAndAnalysisTime)
//            case .edge:
//                needle.setValueInSteps(1.00, totalTime: settings.listenAndAnalysisTime)
//            }
//        } else if state == .settings {
//            switch newPrecision {
//            case .bullsEye:
//                needle.setValue(0.00)
//            case .inner:
//                needle.setValue(0.25)
//            case .middle:
//                needle.setValue(0.50)
//            case .outer:
//                needle.setValue(0.75)
//            case .edge:
//                needle.setValue(1.00)
//            }
//        }
    }
        
    func setState(_ newState: Model.State) {
//        model.setState(newState)
//
//        // needle
//        switch newState {
//        case .wait:
//            displayBackgroundColorful = false
//            needle.active(false, strongNoise: false)
//            needle.setValue(0.5)
//        case .listen:
//            displayBackgroundColorful = true
//            needle.active(true, strongNoise: true)
//        case .analyse:
//            displayBackgroundColorful = true
//            needle.active(true, strongNoise: false)
//        case .show:
//            displayBackgroundColorful = true
//            needle.active(true, strongNoise: false)
//        case .settings:
//            displayBackgroundColorful = true
//            needle.active(true, strongNoise: false)
//        }
    }
    
}
