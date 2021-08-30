//
//  DiskViewModel.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 30/08/2021.
//

import SwiftUI

class DiskViewModel: ObservableObject {
    let callback: (_: Precision) -> Void
    var isSetting: Bool

    @Published var disksVisible = true
    @Published var shapeShifterIsCircle = true
    @Published var shapeShifterIsPale = false
    @Published var shapeShifterIsGray = false
    

    var diskParameters = [DiskParameter]()
    
    func down(_ precision: Precision) {
        print("DiskViewModel down()")
        if !isSetting {
            disksVisible = false
            shapeShifterIsPale = true
        }
    }
    
    func up(_ precision: Precision) {
        print("DiskViewModel up()")
        callback(precision)
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
    
    init(callback: @escaping (_: Precision) -> Void, isSetting: Bool) {
        self.isSetting = isSetting
        self.callback = callback
        diskParameters.append(DiskParameter(.outer))
        diskParameters.append(DiskParameter(.middle))
        diskParameters.append(DiskParameter(.inner))
        diskParameters.append(DiskParameter(.bullsEye))
    }
}
