//
//  Model.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 16/11/2020.
//

import Foundation
import GameKit

class Needle {
    // set the truth
    func setTarget(_ value: Double) { target = value }
    
    var truthCallback: ((Double) -> ())?

    private var _isNoisy: Bool
    var isNoisy: Bool {
        get { _isNoisy }
        set {
            print("Model: new value: \(newValue) old _isNoisy -> \(_isNoisy)")
            if _isNoisy != newValue {
                _isNoisy = newValue
                if newValue {
                    print("Model: set timer")
                    noiseTimer = Timer.scheduledTimer(timeInterval: 0.15, target: self, selector: #selector(addNoise), userInfo: nil, repeats: true)
                    smoothTimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(smooth), userInfo: nil, repeats: true)
                } else {
                    noiseTimer?.invalidate()
                    smoothTimer?.invalidate()
                    noiseTimer = nil
                    smoothTimer = nil
                }
            }
        }
    }
    
    init() {
        target = initialValue
        noisyTarget = initialValue
        currentTruth = initialValue
        _isNoisy = false
    }

    // the rest is private ;)
    private let initialValue = 0.2
    private var currentTruth: Double
    private var target: Double
    private var noisyTarget: Double
    private let distribution = GKGaussianDistribution(lowestValue: -100, highestValue: 100)
    private var noiseTimer: Timer?
    private var smoothTimer: Timer?


    @objc private func addNoise() {
        let n = self.distribution.nextInt()
        let noise = 0.001 * Double(n)
        self.noisyTarget = self.target + noise
//        print("noise added -> \(currentTruth)")
    }

    @objc private func smooth() {
        print("smooth()")
        let f_fast = 0.97
        var newCurrentValue  = f_fast * self.currentTruth + (1-f_fast)*self.noisyTarget
        if newCurrentValue < -0.02 { newCurrentValue = -0.02 }
        if newCurrentValue >  1.02 { newCurrentValue = 1.02 }
        self.currentTruth = newCurrentValue
        self.truthCallback?(self.currentTruth)
    }

    deinit {
        self.noiseTimer?.invalidate()
        self.smoothTimer?.invalidate()
    }
        
}
