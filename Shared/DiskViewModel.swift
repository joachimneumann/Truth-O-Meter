//
//  DiskViewModel.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 30/08/2021.
//

import Foundation

class DiskViewModel: ObservableObject {
    @Published var disksVisible = true
    @Published var shapeShifterIsCircle = true
    @Published var shapeShifterIsPale = false

    class DiskParameter: Identifiable {
        var id = UUID()
        let precision: Precision
        let relativePadding: Double
        
        init(_ precision: Precision) {
            self.precision = precision
            
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
    var isSetting = false
    
    let callback: (_: Precision) -> Void
    
    func down(_ precision: Precision) {
        print("DiskViewModel down(). all unvisible?")
        disksVisible = false
        shapeShifterIsPale = true
    }
    
    func up(_ precision: Precision) {
        print("DiskViewModel up()")
        shapeShifterIsCircle = false
        callback(precision)
        shapeShifterIsPale = false
    }
    
    init(callback: @escaping (_: Precision) -> Void) {
        self.callback = callback
        diskParameters.append(DiskParameter(.outer))
        diskParameters.append(DiskParameter(.middle))
        diskParameters.append(DiskParameter(.inner))
        diskParameters.append(DiskParameter(.bullsEye))
    }
}
