//
//  Target.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 11/11/20.
//

import Foundation
import GameplayKit

class Target: ObservableObject {
    @Published var value = 0.5
    var longTerm = 0.2
    var target: Double = 0.7
    var noisyTarget: Double = 0.5

    private let distribution = GKGaussianDistribution(lowestValue: -100, highestValue: 100)

    lazy var longTermTimer = Timer.scheduledTimer(withTimeInterval: 0.15, repeats: true) { _ in
        let f_slow = 0.9
        self.target = f_slow * self.target + (1-f_slow)*self.longTerm
    }

    lazy var noiseTimer = Timer.scheduledTimer(withTimeInterval: 0.15, repeats: true) { _ in
        let n = self.distribution.nextInt()
        let noise = 0.001 * Double(n)
        self.noisyTarget = self.target + noise
    }

    lazy var lowpassTimer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
        let f_fast = 0.97
//        print("timer: value = \(self.value.format(f: "4.3"))   target = \(self.target.format(f: "4.3"))   noisyTarget = \(self.noisyTarget.format(f: "4.3"))")
        self.value = f_fast * self.value + (1-f_fast)*self.noisyTarget
        if self.value < -0.02 { self.value = -0.02 }
        if self.value > 1.02 { self.value = 1.02 }

    }

    init() {
        longTermTimer.fire()
        noiseTimer.fire()
        lowpassTimer.fire()
    }
    
}

extension Double {
    func format(f: String) -> String {
        return String(format: "%\(f)f", self)
    }
}
