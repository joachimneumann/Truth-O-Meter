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
    @Published var shapeShifterIsPale = false
    @Published var shapeShifterIsGray = false

    var diskParameters = [DiskParameter]()

    init(isSetting iss: Bool) {
        isSetting = iss
        diskParameters.append(DiskParameter(.outer))
        diskParameters.append(DiskParameter(.middle))
        diskParameters.append(DiskParameter(.inner))
        diskParameters.append(DiskParameter(.bullsEye))
    }
    
    func down() {
        if !isSetting {
            disksVisible = false
            shapeShifterIsPale = true
        }
    }
    
    func up(_ precision: Precision) {
        print("ButtonModel up() with precision \(precision)")
        
        // stamp =
        isListening = true
        isAnalysing = false
        isShowingStamp = false

        if isSetting {
            switch precision {
            case .edge:
                shapeShifterIsGray       = true
                diskParameters[0].isGray = false
                diskParameters[1].isGray = false
                diskParameters[2].isGray = false
                diskParameters[3].isGray = false
            case .outer:
                shapeShifterIsGray       = false
                diskParameters[0].isGray = true
                diskParameters[1].isGray = false
                diskParameters[2].isGray = false
                diskParameters[3].isGray = false
            case .middle:
                shapeShifterIsGray       = false
                diskParameters[0].isGray = false
                diskParameters[1].isGray = true
                diskParameters[2].isGray = false
                diskParameters[3].isGray = false
            case .inner:
                shapeShifterIsGray       = false
                diskParameters[0].isGray = false
                diskParameters[1].isGray = false
                diskParameters[2].isGray = true
                diskParameters[3].isGray = false
            case .bullsEye:
                shapeShifterIsGray       = false
                diskParameters[0].isGray = false
                diskParameters[1].isGray = false
                diskParameters[2].isGray = false
                diskParameters[3].isGray = true
            }
        } else {
            shapeShifterIsCircle = false
            shapeShifterIsPale = false
        }
    }
    
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
    }
    
//    func down(_ precision: Precision) {
//        print("DiskViewModel down()")
//        if !isSetting {
//            disksVisible = false
//            shapeShifterIsPale = true
//        }
//    }
}
