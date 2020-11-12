//
//  TruthModel.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 11/12/20.
//

import Foundation

import Foundation
import GameplayKit

class TruthModel: ObservableObject {
    @Published var current = 0.5
    private var noisyApproaching: Double = 0.5
    private var approaching: Double = 0.75
    private var target: Double = 0.5 {
        didSet {
            print("target didSet \(target)")
        }
    }

    private let distribution = GKGaussianDistribution(lowestValue: -100, highestValue: 100)

    func currentValue() -> Double {
        return current
    }

    func newTruth(updateTo: Double) {
        target = updateTo
    }
    // approach the target
    lazy var longTermTimer = Timer.scheduledTimer(withTimeInterval: 0.15, repeats: true) { _ in
        let f_slow = 0.9
        self.approaching = f_slow * self.approaching + (1-f_slow)*self.target
    }

    // add noise approach
    lazy var noiseTimer = Timer.scheduledTimer(withTimeInterval: 0.15, repeats: true) { _ in
        let n = self.distribution.nextInt()
        let noise = 0.001 * Double(n)
        self.noisyApproaching = self.approaching + noise
    }

    // smoothing
    lazy var lowpassTimer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
        let f_fast = 0.97
        self.current = f_fast * self.current + (1-f_fast)*self.noisyApproaching
        if self.current < -0.02 { self.current = -0.02 }
        if self.current > 1.02 { self.current = 1.02 }

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
