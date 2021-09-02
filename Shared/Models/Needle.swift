//
//  Needle.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 02/09/2021.
//

import Foundation
import GameKit // for GKGaussianDistribution
import SwiftUI

class Needle: ObservableObject {
    @Published private(set) var value: Double = 0.5
    @Published private(set) var colorful = false
    
    static var shared = Needle()
    private init() {
    }
    
    private var privateValue: Double = 0
    private var needleNoiseTimer: Timer?
    private let distribution = GKGaussianDistribution(lowestValue: -100, highestValue: 100)
    private var strongNoise = false

    func setValue(_ v: Double) {
        withAnimation(.default) {
            privateValue = v
            value = v
        }
    }
    
    func setValueInSteps(_ newValue: Double, totalTime: Double) {
        var delay = 0.25 * totalTime
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.setValue(self.privateValue + 0.3 * (newValue - self.privateValue))
        }
        delay = 0.5 * totalTime
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.setValue(self.privateValue + 0.6 * (newValue - self.privateValue))
        }
        delay = 0.675 * totalTime
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.setValue(self.privateValue + 0.7 * (newValue - self.privateValue))
        }
        delay = 0.85 * totalTime
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.setValue(newValue)
        }
    }

    func active(_ onOff: Bool, strongNoise: Bool = false) {
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
            value = privateValue + noise
        }
    }

    
}
