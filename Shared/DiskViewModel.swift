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
    
    class DiskParameter: Identifiable {
        var id = UUID()
        let precision: Precision
        let relativePadding: Double
        var isGray: Bool
        
        init(_ precision: Precision) {
            self.precision = precision
            self.isGray = false
            
            // Instead of 0, 0.2, 0.4, 0.6, 0.8, 1.0
            // I make the bulls eye and the out disk a bit larger
            // This makes the edge results easier to hit.
            let tapEdge     = 1.0
            let tapOuter    = 0.8 - 0.05
            let tapMiddle   = 0.6 - 0.0125
            let tapInner    = 0.4 + 0.0125
            let tapBullsEye = 0.2 + 0.05
            switch precision {
            case .edge:
                relativePadding = (1.0 - tapEdge)
            case .outer:
                relativePadding = (1.0 - tapOuter)
            case .middle:
                relativePadding = (1.0 - tapMiddle)
            case .inner:
                relativePadding = (1.0 - tapInner)
            case .bullsEye:
                relativePadding = (1.0 - tapBullsEye)
            }
        }
    }

    var diskParameters = [DiskParameter]()
    
    func down(_ precision: Precision) {
        print("DiskViewModel down()")
        if isSetting {
        } else {
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
