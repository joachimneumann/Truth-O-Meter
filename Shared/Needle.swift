//
//  Needle.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 25/08/2021.
//

import Foundation
import GameKit // for GKGaussianDistribution
import SwiftUI

class Needle: ObservableObject {
    @Published var noisyValue: Double = 0
    @Published private(set) var colorful = false
    
    private var value: Double = 0
    private var needleNoiseTimer: Timer?
    private let distribution = GKGaussianDistribution(lowestValue: -100, highestValue: 100)
    private var strongNoise = false

    func setValue(_ v: Double) {
        withAnimation(.default) {
            value = v
            noisyValue = v
        }
    }
    
    func setValueInSteps(_ newValue: Double, totalTime: Double) {
        var delay = 0.25 * totalTime
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.setValue(self.value + 0.3 * (newValue - self.value))
        }
        delay = 0.5 * totalTime
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.setValue(self.value + 0.6 * (newValue - self.value))
        }
        delay = 0.95 * totalTime
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.setValue(newValue)
        }
    }

    func active(_ onOff: Bool, strongNoise: Bool) {
        self.strongNoise = strongNoise
        if onOff {
            colorful = true
            if needleNoiseTimer == nil {
                needleNoiseTimer = Timer.scheduledTimer(timeInterval: 0.15, target: self, selector: #selector(addNoise), userInfo: nil, repeats: true)
                needleNoiseTimer?.tolerance = 0.1
            }
        } else {
            colorful = false
            if needleNoiseTimer != nil {
                needleNoiseTimer!.invalidate()
                needleNoiseTimer = nil
            }
        }
    }
    
    
    @objc private func addNoise() {
        let n = self.distribution.nextInt()
        var noiseLevel = 0.001
        if strongNoise { noiseLevel *= 3 }
        let noise = noiseLevel * Double(n)
        withAnimation(.default) {
            noisyValue = value + noise
        }
    }

}
