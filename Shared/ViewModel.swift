//
//  ViewModel.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 16/08/2021.
//

import Foundation
import GameKit // for GKGaussianDistribution
import SwiftUI
#if os(macOS)
import AVFoundation // for sound
#endif

class ViewModel: ObservableObject {
    @Published private var model = Model()
    @Published var listeningProgress: CGFloat = 0.0
    @Published var analyseProgress: CGFloat = 0.0
    @Published var imageIndex = 0
    
    private var needleNoiseTimer: Timer?
    private var listenTimer: Timer?
    private var analyseTimer: Timer?
    private var nextImageTimer: Timer?
    private let distribution = GKGaussianDistribution(lowestValue: -100, highestValue: 100)

    @Published var currentValue = 0.5
    
    var activeDisplay: Bool { model.displayActive }
    var displayTitle: String { model.theme.displayText }
    
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
            }
        }
        set{
            switch newValue {
            case 0:
                setState(.wait)
            case 1:
                setState(.listen)
            case 2:
                setState(.analyse)
            case 3:
                setState(.show)
            default:
                setState(.wait)
            }
        }
    }
    
    func setTruthHard(_ t: Double) {
        self.model.setTruth(t)
    }
    func setTruthDynamic(_ t: Double) {
        // a little manipulation to make it easier to hit the extremes (center and edge
        var truth = t - 0.1
        if truth < 0 { truth = 0 }
        truth *= 1.2
        if truth > 1.0 { truth = 1.0 }
        
        var delay = 0.25 * model.listenAndAnalysisTime
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.model.setTruth(self.model.truth + 0.3 * (truth - self.model.truth))
        }
        delay = 0.5 * model.listenAndAnalysisTime
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.model.setTruth(self.model.truth + 0.6 * (truth - self.model.truth))
        }
        delay = 0.95 * model.listenAndAnalysisTime
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.model.setTruth(truth)
        }
    }

    var stampTexts: StampTexts = StampTexts("top", "bottom")
    
    var state: Model.State {
        get { model.state }
    }
    
    func setState(_ s: Model.State) {
        model.setState(s)
        
        nextImageTimer?.invalidate()
        nextImageTimer = nil
        needleNoiseTimer?.invalidate()
        needleNoiseTimer = nil
        listenTimer?.invalidate()
        listenTimer = nil

        switch model.state {
        case .wait:
            setTruthHard(0.5);
            currentValue = 0.5
            break
        case .listen:
            AudioServicesPlaySystemSound(C.Sounds.startRecording)
            listeningProgress = 0.0
            listenTimer = Timer.scheduledTimer(timeInterval: C.Timing.listeningTimeIncrement, target: self, selector: #selector(incrementListeningProgress), userInfo: nil, repeats: true)
        case .analyse:
            AudioServicesPlaySystemSound(C.Sounds.stopRecording)
            analyseProgress = 0.0
            nextImageTimer = Timer.scheduledTimer(timeInterval: 0.025, target: self, selector: #selector(nextImage), userInfo: nil, repeats: true)
            analyseTimer = Timer.scheduledTimer(timeInterval: C.Timing.analyseTimeIncrement, target: self, selector: #selector(incrementAnalyseProgress), userInfo: nil, repeats: true)
        case .show:
            if model.truth < 0.2 {
                stampTexts = model.theme.farLeft
            } else if model.truth < 0.4 {
                stampTexts = model.theme.left
            } else if model.truth < 0.6 {
                stampTexts = model.theme.center
            } else if model.truth < 0.8 {
                stampTexts = model.theme.right
            } else {
                stampTexts = model.theme.farRight
            }
            break
        }
        if (model.displayActive) {
            needleNoiseTimer = Timer.scheduledTimer(timeInterval: 0.15, target: self, selector: #selector(addNoise), userInfo: nil, repeats: true)
        }
    }
    
    
    @objc func nextImage() {
        self.imageIndex += 1
        if self.imageIndex > 105 { self.imageIndex = 0 }
    }
    
    @objc private func incrementListeningProgress() {
        DispatchQueue.main.async {
            self.listeningProgress += CGFloat(C.Timing.listeningTimeIncrement/self.model.listenTime)
        }
        if listeningProgress >= 1.0 {
            setState(.analyse)
            listenTimer?.invalidate()
        }
    }

    @objc private func incrementAnalyseProgress() {
        DispatchQueue.main.async {
            self.analyseProgress += CGFloat(C.Timing.analyseTimeIncrement/self.model.analysisTime)
        }
        if analyseProgress >= 1.0 {
            setState(.show)
            analyseTimer?.invalidate()
            nextImageTimer?.invalidate()
        }
    }
    
    @objc private func addNoise() {
        let n = self.distribution.nextInt()
        var noiseLevel = 0.001
        if model.state == .listen { noiseLevel *= 3 }
        let noise = noiseLevel * Double(n)
        withAnimation(.default) {
            self.currentValue = self.model.truth + noise
        }
    }

}
