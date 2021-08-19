//
//  TruthViewModel.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 16/08/2021.
//

import Foundation
import GameKit // for GKGaussianDistribution

class TruthViewModel: ObservableObject {
    @Published private var model = Model()
    
    private var noisyTruth = 0.0
    private var noiseTimer: Timer?
    private var smoothTimer: Timer?
    private let distribution = GKGaussianDistribution(lowestValue: -100, highestValue: 100)

    var recordButtonValue: CGFloat = 1.0
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

    func intentListenToNewQuestion() {
        
    }
    
    var state: Model.State {
        return model.state
    }
    
    func setState(_ s: Model.State) {
        model.setState(s)
        updateTimer()
    }

    func updateTimer() {
        if (model.displayActive) {
            if (noiseTimer == nil) {
                noiseTimer = Timer.scheduledTimer(timeInterval: 0.15, target: self, selector: #selector(addNoise), userInfo: nil, repeats: true)
            }
            if (smoothTimer == nil) {
                smoothTimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(smooth), userInfo: nil, repeats: true)
            }
        } else {
            noiseTimer?.invalidate()
            smoothTimer?.invalidate()
            noiseTimer = nil
            smoothTimer = nil
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
