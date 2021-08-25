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
    
    var needle = Needle()
    
    private var model = Model()

    @Published var settings = Settings()
    @Published var listeningProgress: CGFloat = 0.0
    @Published var analyseProgress: CGFloat = 0.0
    @Published var displayBackgroundColorful = false
    private var listenTimer: Timer?
    private var analyseTimer: Timer?
        
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
        
    var state: Model.State {
        get { model.state }
    }
    
    func tap(_ ring: TapPrecision) {
        print("tap(ring = \(ring))")
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
        if let r = settings.currentTheme.results[ring] {
            settings.currentTheme.stampTexts = r
        } else {
            settings.currentTheme.stampTexts = Result("top", "bottom")
        }
        print("settings.currentTheme.stampTexts = \(settings.currentTheme.stampTexts.top)")
        self.objectWillChange.send()
    }
    
    func setStateWithoutTimer(_ newState: Model.State) {

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

    func setState(_ newState: Model.State) {

        model.setState(newState)

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
            self.listeningProgress += CGFloat(C.Timing.listeningTimeIncrement/self.settings.listenTime)
        }
        if listeningProgress >= 1.0 {
            setState(.analyse)
            listenTimer?.invalidate(); listenTimer = nil
        }
    }

    @objc private func incrementAnalyseProgress() {
        DispatchQueue.main.async {
            self.analyseProgress += CGFloat(C.Timing.analyseTimeIncrement/self.settings.analysisTime)
        }
        if analyseProgress >= 1.0 {
            setState(.show)
            analyseTimer?.invalidate();   analyseTimer = nil
        }
    }

}
