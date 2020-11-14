//
//  TruthModel.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 11/12/20.
//

import SwiftUI
import GameplayKit

class NeedlePosition: ObservableObject {
    @Published var value = 0.5
}

protocol NextTargetDelegate {
    func nextTarget(value: Double)
}

class NextTarget: ObservableObject {
    var delegate: NextTargetDelegate?
    @Published var value = 0.5 {
        didSet {
            print("NextTarget set to \(value)")
            delegate?.nextTarget(value: value)
        }
    }
}

class TruthModel: NextTargetDelegate {
    private var timer1 : DispatchSourceTimer?
    private var timer2 : DispatchSourceTimer?
    private var timer3 : DispatchSourceTimer?
    func nextTarget(value: Double) {
        
        if timer1 != nil { timer1?.cancel(); timer1 = nil }
        if timer2 != nil { timer2?.cancel(); timer2 = nil }
        if timer3 != nil { timer3?.cancel(); timer3 = nil }

        let inversed = 1.0 - value
        
        // timer0, instantaneous
        self.target = self.target + 0.1*(inversed-self.target)
        
        if timer1 == nil {
            timer1 = DispatchSource.makeTimerSource(queue: DispatchQueue.global())
            timer1?.schedule(deadline:.now() + times[0])
            timer1?.setEventHandler {
                self.target = self.target + 0.2*(inversed-self.target)
                self.timer1 = nil
            }
            timer1?.resume()
        }

        if timer2 == nil {
            timer2 = DispatchSource.makeTimerSource(queue: DispatchQueue.global())
            timer2?.schedule(deadline:.now() + times[1])
            timer2?.setEventHandler {
                self.target = self.target + 0.3*(inversed-self.target)
                self.timer2 = nil
            }
            timer2?.resume()
        }

        if timer3 == nil {
            timer3 = DispatchSource.makeTimerSource(queue: DispatchQueue.global())
            timer3?.schedule(deadline:.now() + times[2])
            timer3?.setEventHandler {
                self.target = inversed
                self.timer3 = nil
            }
            timer3?.resume()
        }
    }
    
    static let shared = TruthModel()
    var needlePosition = NeedlePosition()
    var nextTarget = NextTarget()

    private var noisy: Double = 0.5
    var target: Double = 0.5
    private var times = [1.0, 2.0, 3.0]
    private let distribution = GKGaussianDistribution(lowestValue: -100, highestValue: 100)

    private init() {
        noiseTimer.fire()
        lowpassTimer.fire()
        nextTarget.delegate = self
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
        var newCurrentValue  = f_fast * self.needlePosition.value + (1-f_fast)*self.noisy
        if newCurrentValue < -0.02 { newCurrentValue = -0.02 }
        if newCurrentValue >  1.02 { newCurrentValue = 1.02 }
        self.needlePosition.value = newCurrentValue
    }
    
}

extension Double {
    func format(f: String) -> String {
        return String(format: "%\(f)f", self)
    }
}
