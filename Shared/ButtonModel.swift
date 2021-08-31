//
//  ButtonModel.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 30/08/2021.
//

import Foundation

class ButtonModel: ObservableObject {
    @Published var isShowingStamp = false
    @Published var isListening = false
    @Published var isAnalysing = false
    @Published var result = Result("top", "bottom")
    var isSetting: Bool
    
    @Published var disksVisible = true
    @Published var shapeShifterIsCircle = true
    var shapeShifterIsPale = false
    @Published var shapeShifterIsGray = false

    private var settings = Settings()

    init(isSetting iss: Bool) {
        isSetting = iss
    }
    
    func down() {
        if !isSetting {
            disksVisible = false
            shapeShifterIsPale = true
        }
    }
    
    func buttonPressedWith(_ precision: Precision) {
        print("ButtonModel buttonPressedWith(\(precision))")
        result = settings.currentTheme.result(forPrecision: precision)
        isListening = true
        isAnalysing = false
        isShowingStamp = false
    }
    
    // MARK: intents
    func listeningFinished() {
        isListening = false
        isAnalysing = true
        isShowingStamp = false
        analysingFinished()
    }
    
    func analysingFinished() {
        isListening = false
        isAnalysing = false
        isShowingStamp = true
    }

    func startOver() {
        isListening = false
        isAnalysing = false
        isShowingStamp = false
        shapeShifterIsPale = false
        shapeShifterIsCircle = true
        shapeShifterIsGray = false
        isSetting = false
    }

}
