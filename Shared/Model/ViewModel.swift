//
//  ViewModel.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 04/04/2021.
//

import SwiftUI

class ViewModel: ObservableObject {
    private(set) var model: Model

    @Published var progressBarValue = 1.0
    @Published var animatedImage: UIImage? = nil
    
    func currentState() -> String {
        return model.value.description()
    }

    // MARK: intents
    func intentListenToNewQuestion() {
        model.value = .listen
        let timeInterval = 0.0020
        self.progressBarValue = 0.0
        Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true) { timer in
            self.progressBarValue += timeInterval / progressDuration
            print(self.progressBarValue)
            if (self.progressBarValue >= 1.0) {
                timer.invalidate()
                self.model.value = .analyse
            }
        }
    }
    
    
    init() {
        model = Model()
//        let loading_1 = UIImage(named: "x000.png")!
//        let loading_2 = UIImage(named: "x050.png")!
//        let loading_3 = UIImage(named: "x100.png")!
//        let images = [loading_1, loading_2, loading_3]
//        animatedImage = UIImage.animatedImage(with: images, duration: 0.1)
    }
    init(_ s: Model.StateEnum) {
        model = Model()
        model.value = s
    }
}
