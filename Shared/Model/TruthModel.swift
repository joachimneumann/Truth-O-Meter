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
    private var noisy: Double = 0.5
    private var target: Double = 0.5 {
        didSet {
            print("target didSet \(target.format(f: ".3"))")
        }
    }
    private var times = [1.0, 2.0, 3.0]

    private let distribution = GKGaussianDistribution(lowestValue: -100, highestValue: 100)

    func currentValue() -> Double {
        return current
    }

    func newTruth(updateTo: Double) {
        let inversed = 1.0 - updateTo
        self.target = self.target + 0.2*(inversed-self.target)
        DispatchQueue.main.asyncAfter(deadline: .now() + times[0]) {
            self.target = self.target + 0.4*(inversed-self.target)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + times[1]) {
            self.target = self.target + 0.75*(inversed-self.target)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + times[2]) {
            self.target = inversed
        }
    }

    init() {
        noiseTimer.fire()
        lowpassTimer.fire()
    }

    // add noise approach
    private lazy var noiseTimer = Timer.scheduledTimer(withTimeInterval: 0.15, repeats: true) { _ in
        let n = self.distribution.nextInt()
        let noise = 0.001 * Double(n)
        self.noisy = self.target + noise
    }

    // smoothing
    private lazy var lowpassTimer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
        let f_fast = 0.97
        self.current = f_fast * self.current + (1-f_fast)*self.noisy
        if self.current < -0.02 { self.current = -0.02 }
        if self.current > 1.02 { self.current = 1.02 }

    }
    
}

extension Double {
    func format(f: String) -> String {
        return String(format: "%\(f)f", self)
    }
}
