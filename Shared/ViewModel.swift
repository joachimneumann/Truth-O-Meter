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
    var displayTitle: String { model.displayTitle }
    var stateName: String { // for ModelDebugView
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

    var times = [2.0, 3.0, 4.0, 6.0]
//    let responseTime = 1
//    switch responseTime {
//        case 0: // fast
//            times = [0.5, 1.0, 1.5, 2.0]
//        case 1: // medium
//            times = [1.0, 2.0, 3.0, 4.0]
//        case 2: // slow
//            times = [2.0, 3.0, 4.0, 6.0]
//        default: times = [2.0, 3.0, 4.0, 6.0]
//    }

    
    func setTruth(_ t: Double) {
        // a little manipulation to make it easier to hit the extremes (center and edge
        var truth = t - 0.1
        if truth < 0 { truth = 0 }
        truth *= 1.2
        if truth > 1.0 { truth = 1.0 }
        
        currentValue = 0.5 - 0.2 * (truth-0.5)

        DispatchQueue.main.asyncAfter(deadline: .now() + times[0]) {
            self.model.setTruth(self.model.truth + 0.3 * (truth - self.model.truth))
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + times[1]) {
            self.model.setTruth(self.model.truth + 0.6 * (truth - self.model.truth))
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + times[2]) {
            self.model.setTruth(truth)
//            var text1: String = ""
//            var text2: String = ""
//            if truthIndex < 0.2 {
//                text1 = Model.shared.theme().farRightText1
//                text2 = Model.shared.theme().farRightText2
//            } else if truthIndex < 0.4 {
//                text1 = Model.shared.theme().rightText1
//                text2 = Model.shared.theme().rightText2
//            } else if truthIndex < 0.6 {
//                text1 = Model.shared.theme().centerText1
//                text2 = Model.shared.theme().centerText2
//            } else if truthIndex < 0.8 {
//                text1 = Model.shared.theme().leftText1
//                text2 = Model.shared.theme().leftText2
//            } else {
//                text1 = Model.shared.theme().farLeftText1
//                text2 = Model.shared.theme().farLeftText2
//            }
//            self.rubberstamp.setTextArray(texts: [text1, text2])
        }
    }

    var state: Model.State {
        get { model.state}
        set { setState(newValue) }
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
        let noise = 0.001 * Double(n)
        withAnimation(.default) {
            self.currentValue = self.model.truth + noise
        }
    }

}
