//
//  ViewModel.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 16/08/2021.
//

import Foundation
import GameKit // for Audio
import SwiftUI
#if os(macOS)
import AVFoundation // for sound
#endif

class ViewModel: ObservableObject {
    var needle: Needle
    private var model = Model()
    @Published var listeningProgress: CGFloat = 0.0
    @Published var analyseProgress: CGFloat = 0.0
    @Published var displayBackgroundColorful = false
    private var listenTimer: Timer?
    private var analyseTimer: Timer?
    
    var displayTitle: String { model.currentTheme.displayText }
    
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
    
    var stateIndex: Int { // for ModelDebugView
        get {
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
            switch newValue {
            case 0:
                setStateWithoutTimer(.wait)
            case 1:
                setStateWithoutTimer(.listen)
            case 2:
                setStateWithoutTimer(.analyse)
            case 3:
                setStateWithoutTimer(.show)
            case 4:
                setStateWithoutTimer(.settings)
            default:
                setStateWithoutTimer(.wait)
            }
        }
    }
    
    init(_ needle_: Needle) {
        needle = needle_
    }
    
    var stampTexts: Result = Result("top", "bottom")
    
    var state: Model.State {
        get { model.state }
    }
    
    func tap(_ ring: Model.TapPrecision) {
        if state == .wait {
            setState(.listen)
            switch ring {
            case .bullsEye:
                needle.setValueInSteps(0.00, totalTime: model.listenAndAnalysisTime)
            case .inner:
                needle.setValueInSteps(0.25, totalTime: model.listenAndAnalysisTime)
            case .middle:
                needle.setValueInSteps(0.50, totalTime: model.listenAndAnalysisTime)
            case .outer:
                needle.setValueInSteps(0.75, totalTime: model.listenAndAnalysisTime)
            case .edge:
                needle.setValueInSteps(1.00, totalTime: model.listenAndAnalysisTime)
            }
        } else if state == .settings {
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
        if let r = model.currentTheme.results[ring] {
            stampTexts = r
        } else {
            stampTexts = Result("top", "bottom")
        }
    }
    
    var themes: [Theme] {
        model.themes
    }
    
    var currentTheme: Theme {
        get { model.currentTheme }
        set { model.currentTheme = newValue }
    }
    
    
    func setStateWithoutTimer(_ newState: Model.State) {

        // needle
        switch newState {
        case .wait:
            displayBackgroundColorful = true
            needle.active(true, strongNoise: false)
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

        model.setState(newState)

    }

    func setState(_ newState: Model.State) {

        // Timer
        switch newState {
        case .wait:
            listenTimer?.invalidate();      listenTimer = nil
            analyseTimer?.invalidate();     analyseTimer = nil
        case .listen:
            if listenTimer == nil {
                listeningProgress = 0.0
                listenTimer = Timer.scheduledTimer(timeInterval: C.Timing.listeningTimeIncrement, target: self, selector: #selector(incrementListeningProgress), userInfo: nil, repeats: true)
                listenTimer?.tolerance = 0.1
            }
            analyseTimer?.invalidate();     analyseTimer = nil
        case .analyse:
            listenTimer?.invalidate();      listenTimer = nil
            if analyseTimer == nil {
                analyseProgress = 0.0
                analyseTimer = Timer.scheduledTimer(timeInterval: C.Timing.analyseTimeIncrement, target: self, selector: #selector(incrementAnalyseProgress), userInfo: nil, repeats: true)
            }
        case .show:
            listenTimer?.invalidate();      listenTimer = nil
            analyseTimer?.invalidate();     analyseTimer = nil
        case .settings:
            listenTimer?.invalidate();      listenTimer = nil
            analyseTimer?.invalidate();     analyseTimer = nil
        }

        // sounds
        switch newState {
        case .listen:
            AudioServicesPlaySystemSound(C.Sounds.startRecording)
        case .analyse:
            AudioServicesPlaySystemSound(C.Sounds.stopRecording)
        default:
            break
        }

        setStateWithoutTimer(newState)
    }
    
    @objc private func incrementListeningProgress() {
        DispatchQueue.main.async {
            self.listeningProgress += CGFloat(C.Timing.listeningTimeIncrement/self.model.listenTime)
        }
        if listeningProgress >= 1.0 {
            setState(.analyse)
            listenTimer?.invalidate(); listenTimer = nil
        }
    }

    @objc private func incrementAnalyseProgress() {
        DispatchQueue.main.async {
            self.analyseProgress += CGFloat(C.Timing.analyseTimeIncrement/self.model.analysisTime)
        }
        if analyseProgress >= 1.0 {
            setState(.show)
            analyseTimer?.invalidate();   analyseTimer = nil
        }
    }

}
