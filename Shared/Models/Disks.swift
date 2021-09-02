//
//  Disks.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 30/08/2021.
//

import Foundation
import CoreGraphics

struct Disks {
    var disks = [Disk]()
    
    init() {
        // Instead of 0, 0.2, 0.4, 0.6, 0.8, 1.0
        // I make the bulls eye and the out disk a bit larger
        // This makes the edge results easier to hit.
        let outer:CGFloat    = 0.8 - 0.05
        let middle:CGFloat   = 0.6 - 0.0125
        let inner:CGFloat    = 0.4 + 0.0125
        let bullsEye:CGFloat = 0.2 + 0.05
        disks.append(Disk(.outer,    relativePadding: (1.0 - outer)))
        disks.append(Disk(.middle,   relativePadding: (1.0 - middle)))
        disks.append(Disk(.inner,    relativePadding: (1.0 - inner)))
        disks.append(Disk(.bullsEye, relativePadding: (1.0 - bullsEye)))
    }
    
    struct Disk: Identifiable {
        var id = UUID()
        let precision: Precision
        private var isGray: Bool
        private var relativePadding: CGFloat
        
        init(_ precision: Precision, relativePadding padding: CGFloat) {
            self.precision = precision
            self.isGray = false
            self.relativePadding = padding
        }
        
        func padding(radius: CGFloat) -> CGFloat {
            return radius * relativePadding
        }
    }
}
