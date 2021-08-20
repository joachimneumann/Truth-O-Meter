//
//  ViewModel.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 16/08/2021.
//

import Foundation
import GameKit // for GKGaussianDistribution

class ViewModel: ObservableObject {
    @Published private var model = Model()
    @Published var ringProgress: CGFloat = 1.0
    @Published var imageIndex = 0
    
    private var noisyTruth = 0.0
    private var needleNoiseTimer: Timer?
    private var needleSmoothTimer: Timer?
    private var listenTimer: Timer?
    private var nextImageTimer: Timer?
    private let distribution = GKGaussianDistribution(lowestValue: -100, highestValue: 100)

    var currentValue = 0.5
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

    var state: Model.State {
        return model.state
    }
    
    func setState(_ s: Model.State) {
        model.setState(s)
        if state == .listen {
            ringProgress = 0.0
            listenTimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(advanceListenProgress), userInfo: nil, repeats: true)
        }
        if state == .analyse {
            ringProgress = 0.0
            listenTimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(advanceListenProgress), userInfo: nil, repeats: true)
            nextImageTimer = Timer.scheduledTimer(timeInterval: 0.025, target: self, selector: #selector(nextImage), userInfo: nil, repeats: true)
        }
        if (model.displayActive) {
            if (needleNoiseTimer == nil) {
                needleNoiseTimer = Timer.scheduledTimer(timeInterval: 0.15, target: self, selector: #selector(addNoise), userInfo: nil, repeats: true)
            }
            if (needleSmoothTimer == nil) {
                needleSmoothTimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(smooth), userInfo: nil, repeats: true)
            }
        } else {
            needleNoiseTimer?.invalidate()
            needleSmoothTimer?.invalidate()
            needleNoiseTimer = nil
            needleSmoothTimer = nil
        }
    }
    
    @objc func nextImage() {
        self.imageIndex += 1
        if self.imageIndex > 105 { self.imageIndex = 0 }
    }
    
    @objc private func advanceListenProgress() {
        ringProgress += 0.0031
        if ringProgress >= 1.0 {
            listenTimer?.invalidate()
            listenTimer = nil
            if state == .listen {
                setState(.analyse)
            } else if state == .analyse {
                setState(.show)
            }
        }
    }
    
    @objc private func addNoise() {
        let n = self.distribution.nextInt()
        let noise = 0.01 * Double(n)
        self.noisyTruth = self.model.truth + noise
    }
    
    @objc private func smooth() {
        // smooth is called more often than addNoise
        // Thus, objectWillChange.send() is called here
        let f_fast = 0.97
        var newCurrentValue  = f_fast * self.model.truth + (1-f_fast)*self.noisyTruth
        if newCurrentValue < -0.02 { newCurrentValue = -0.02 }
        if newCurrentValue >  1.02 { newCurrentValue = 1.02 }
        self.currentValue = newCurrentValue
        objectWillChange.send()
    }
}
