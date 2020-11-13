//
//  TruthModel.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 11/12/20.
//

import SwiftUI
import GameplayKit

class Current: ObservableObject {
    @Published var value = 0.5
}

class TruthModel {
    
    static let shared = TruthModel()
    var current = Current()
    
    private var noisy: Double = 0.5
    private var target: Double = 0.5
//    {
//        didSet {
//            print("target didSet \(target.format(f: ".3"))")
//        }
//    }
    private var times = [1.0, 2.0, 3.0]
    private let distribution = GKGaussianDistribution(lowestValue: -100, highestValue: 100)

    func newTruthValue(updateTo: Double) {
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

    private init() {
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
        var newCurrentValue  = f_fast * self.current.value + (1-f_fast)*self.noisy
        if newCurrentValue < -0.02 { newCurrentValue = -0.02 }
        if newCurrentValue >  1.02 { newCurrentValue = 1.02 }
        self.current.value = newCurrentValue
    }
    
}

extension Double {
    func format(f: String) -> String {
        return String(format: "%\(f)f", self)
    }
}
