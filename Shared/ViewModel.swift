//
//  ViewModel.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 16/08/2021.
//

import Foundation
import GameKit // for GKGaussianDistribution
import SwiftUI

class ViewModel: ObservableObject {
    @Published private var model = Model()
    @Published var ringProgress: CGFloat = 0.0
    @Published var imageIndex = 0
    
    private var needleNoiseTimer: Timer?
    private var listenTimer: Timer?
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

    var state: Model.State {
        return model.state
    }
    
    init() {
        setState(state)
    }

    func setState(_ s: Model.State) {
        model.setState(s)
        if state == .listen || state == .analyse {
            ringProgress = 0.0
            listenTimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(advanceListenProgress), userInfo: nil, repeats: true)
        }
        if state == .analyse {
            nextImageTimer = Timer.scheduledTimer(timeInterval: 0.025, target: self, selector: #selector(nextImage), userInfo: nil, repeats: true)
        }
        if (model.displayActive) {
            if (needleNoiseTimer == nil) {
                needleNoiseTimer = Timer.scheduledTimer(timeInterval: 0.15, target: self, selector: #selector(addNoise), userInfo: nil, repeats: true)
            }
        } else {
            needleNoiseTimer?.invalidate()
            needleNoiseTimer = nil
        }
    }
    
    
    @objc func nextImage() {
        self.imageIndex += 1
        if self.imageIndex > 105 { self.imageIndex = 0 }
    }
    
    @objc private func advanceListenProgress() {
        DispatchQueue.main.async {
            self.ringProgress += 0.001
        }
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
        let noise = 0.001 * Double(n)
        withAnimation(.default) {
            self.currentValue = self.model.truth + noise
        }
    }

}
