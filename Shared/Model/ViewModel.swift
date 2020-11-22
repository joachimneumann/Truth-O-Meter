//
//  ViewModel.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 16/11/2020.
//

import SwiftUI

//class xNeedleViewModel: ObservableObject, TruthObserver {
//    @Published private var needlePosition: Double
//    private var model: Truth
//    func hasChanged() {
//        needlePosition = model.movingTruth
//    }
//    init(model: Truth) {
//        self.model = model
//        needlePosition = model.movingTruth
//    }
//}
class ViewModel: ObservableObject {
    private let model: Model
    @Published var needlePosition: Double = 0
//    private var timer1 : DispatchSourceTimer?
//    private var timer2 : DispatchSourceTimer?
//    private var timer3 : DispatchSourceTimer?
//    private var times = [1.0, 2.0, 3.0]

    
    func update(value: Double) {
        needlePosition = value
        objectWillChange.send()
    }
    
    private var _isMoving = false
    var isMoving: Bool {
        get {
            _isMoving
        }
        set {
            print("ViewModel: newValue for isMoving: \(newValue). model.isNoisy = \(model.isNoisy)")

            if _isMoving != newValue {
                _isMoving = newValue
                model.isNoisy = newValue
                print("ViewModel: model.isNoisy -> \(newValue). model.isNoisy = \(model.isNoisy)")
                update(value: needlePosition)
            }
        }
    }
    init() {
        model = Model()
        model.truthCallback = update
    }

    // MARK: - user Intents
//    func newtargetIntent(_ value: Double) {
//        if timer1 != nil { timer1?.cancel(); timer1 = nil }
//        if timer2 != nil { timer2?.cancel(); timer2 = nil }
//        if timer3 != nil { timer3?.cancel(); timer3 = nil }
//
//        let inversed = 1.0 - value
//
//        // timer0, instantaneous
//        model.setTarget(0.1*(inversed-model.currentTruth))
//
//        if timer1 == nil {
//            timer1 = DispatchSource.makeTimerSource(queue: DispatchQueue.global())
//            timer1?.schedule(deadline:.now() + times[0])
//            timer1?.setEventHandler {
//                self.model.setTarget(self.model.currentTruth + 0.2*(inversed-self.model.currentTruth))
//                self.timer1 = nil
//            }
//            timer1?.resume()
//        }
//
//        if timer2 == nil {
//            timer2 = DispatchSource.makeTimerSource(queue: DispatchQueue.global())
//            timer2?.schedule(deadline:.now() + times[1])
//            timer2?.setEventHandler {
//                self.model.setTarget(self.model.currentTruth + 0.3*(inversed-self.model.currentTruth))
//                self.timer2 = nil
//            }
//            timer2?.resume()
//        }
//
//        if timer3 == nil {
//            timer3 = DispatchSource.makeTimerSource(queue: DispatchQueue.global())
//            timer3?.schedule(deadline:.now() + times[2])
//            timer3?.setEventHandler {
//                self.model.setTarget(inversed)
//                self.timer3 = nil
//            }
//            timer3?.resume()
//        }
//    }
}
