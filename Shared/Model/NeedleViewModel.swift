//
//  NeedleViewModel.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 16/11/2020.
//

import SwiftUI


class NeedleViewModel: ObservableObject {
    @Published private var needle: Needle
    var position: Double = 0
//    private var timer1 : DispatchSourceTimer?
//    private var timer2 : DispatchSourceTimer?
//    private var timer3 : DispatchSourceTimer?
//    private var times = [1.0, 2.0, 3.0]

    func update(value: Double) {
        position = value
        objectWillChange.send()
    }
    
    @objc func newTarget(_ notification: NSNotification){
        if let target = notification.object as? Double {
            needle.setTarget(target)
        }
    }
    
    var isMoving: Bool {
        get {
            needle.isNoisy
        }
        set {
            print("ViewModel: newValue for isMoving: \(newValue). model.isNoisy = \(needle.isNoisy)")
            if newValue != needle.isNoisy {
                needle.isNoisy = newValue
                print("ViewModel: model.isNoisy -> \(newValue). model.isNoisy = \(needle.isNoisy)")
                objectWillChange.send()
            }
        }
    }
    init() {
        needle = Needle() // TODO: why can't I use update as paramter in Model?
        needle.truthCallback = update
        NotificationCenter.default.addObserver(self, selector: #selector(self.newTarget(_:)), name: Notification.Name(rawValue: "newTarget"), object: nil)
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
