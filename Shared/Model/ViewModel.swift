////
////  ViewModel.swift
////  Truth-O-Meter
////
////  Created by Joachim Neumann on 04/04/2021.
////
//
//import SwiftUI
//import AVFoundation // for sounds
//
//class ViewModel: ObservableObject {
//    private var model: Model
//    @Published var progressBarValue = 1.0
//    @Published var modelValue: Model.State?
//    @Published var animatedImage: UIImage? = nil
//    
//    
////    func currentState() -> String {
////        return model.stateName
////    }
//    
//    func displayActive() -> Bool {
//        return true
////        switch model.state {
////            case .wait:
////                return false
////            case .listen:
////                return true
////            case .analyse:
////                return true
////            case .show:
////                return false
////        }
//    }
//    
//    func displayTitle() -> String {
//        return "Truth-O-Meter"
//    }
//
//    // MARK: intents
//    func intentListenToNewQuestion() {
//////        model.value = .analyse
////        AudioServicesPlaySystemSound(C.Sounds.startRecording)
////        model.state = .listen
////        modelValue = .listen
////        self.progressBarValue = 0.0
////        let timeInterval = 0.005
////        Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true) { timer in
////            // recording sound (fake, of course)
////            self.progressBarValue += timeInterval / C.Timing.listening
////            print(self.progressBarValue)
////            if (self.progressBarValue >= 1.0) {
////                AudioServicesPlaySystemSound(C.Sounds.stopRecording)
////                timer.invalidate()
////                self.model.state = .analyse
////                self.modelValue = .analyse
////                // Analysing (fake, of course)
////                DispatchQueue.main.asyncAfter(deadline: .now() + C.Timing.analyse) {
////                    // Analysing Done (fake, of course)
////                    print("analyse done -> show")
////                    self.model.state = .show
////                }
////            }
////        }
//    }
//    
//    
//    init() {
//        model = Model()
//    }
//
//    init(_ s: Model.State) {
//        model = Model()
////        model.state = s
//    }
//}
