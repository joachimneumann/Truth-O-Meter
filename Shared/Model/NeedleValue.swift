//
//  NeedleValue.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 11/11/20.
//

import Foundation
import GameplayKit

class NeedleValue: ObservableObject {
    @Published var value = 0.5
    var target: Double = 0.5
    var noisyTarget: Double = 0.5

    private let distribution = GKGaussianDistribution(lowestValue: -100, highestValue: 100)

    lazy var noiseTimer = Timer.scheduledTimer(withTimeInterval: 0.15, repeats: true) { _ in
        let n = self.distribution.nextInt()
        let noise = 0.001 * Double(n)
        self.noisyTarget = self.target + noise
    }

    lazy var lowpassTimer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
        let f = 0.97
//        print("timer: value = \(self.value.format(f: "4.3"))   target = \(self.target.format(f: "4.3"))   noisyTarget = \(self.noisyTarget.format(f: "4.3"))")
        self.value = f * self.value + (1-f)*self.noisyTarget
        if self.value < -0.02 { self.value = -0.02 }
        if self.value > 1.02 { self.value = 1.02 }

    }

    init() {
        noiseTimer.fire()
        lowpassTimer.fire()
    }
    
}

extension Double {
    func format(f: String) -> String {
        return String(format: "%\(f)f", self)
    }
}
