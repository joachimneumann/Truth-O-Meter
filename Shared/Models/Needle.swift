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
    // The NeedleView uses @ObservedObject
    // Views that change the value use the singleton, but do not use @ObservedObject
    // to avoid invalidating these views when the needle value changes
    // The class is implemented as singleton for easy access in these Views
    // @EnvironmentObject was not an option, because all views that use Needle
    // would be invalidated on all value changes of Needle
    
    @Published private(set) var noisyValue: Double = 0.5
    @Published private(set) var colorful = false
    
    static var shared = Needle()
    private init() {
    }
    
    private var _value: Double = 0
    private var needleNoiseTimer: Timer?
    private let distribution = GKGaussianDistribution(lowestValue: -100, highestValue: 100)
    private var strongNoise = false

    func setValue(_ newValue: Double) {
        _value = newValue
        noisyValue = newValue
    }

    func setValueInSteps(_ newValue: Double, totalTime: Double) {
        self.active(true, strongNoise: true)
        var delay = 0.25 * totalTime
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.setValue(self._value + 0.3 * (newValue - self._value))
        }
        delay = 0.5 * totalTime
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.setValue(self._value + 0.6 * (newValue - self._value))
        }
        delay = 0.675 * totalTime
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.active(true, strongNoise: false)
            self.setValue(self._value + 0.7 * (newValue - self._value))
        }
        delay = 0.85 * totalTime
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.active(true, strongNoise: false)
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
        noisyValue = _value + noise
//        print("_value\(_value.f) noise=\(noise.f) noisyValue=\(noisyValue.f)")
    }

    
}

extension Double {
    func format(f: String) -> String {
        return String(format: "%\(f)f", self)
    }
}

extension Double {
    var f: String {
        String(format: "%7.3f", self)
    }
}
