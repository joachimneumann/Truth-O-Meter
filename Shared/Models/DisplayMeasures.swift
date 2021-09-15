//
//  DisplayMeasures.swift
//  Truth-O-Meter (iOS)
//
//  Created by Joachim Neumann on 15/09/2021.
//

import CoreGraphics

struct DisplayMeasures {
    let startAngle: Double
    let endAngle: Double
    let midAngle: Double
    let thinLine: Double
    let thickLine: Double
    let borderLine: Double
    let radius1: Double
    let radius2: Double
    let radius3: Double
    let needleYOffset: Double
    let displayCenter: CGPoint

    let completeAngle: Double = 102.0 * .pi / 180.0

    func angle(forProportion proportion: Double) -> Double {
        startAngle + (endAngle - startAngle) * proportion
    }
    
    private let size: CGSize
    private let thickLineFactor = 7.0
    
    init(_ forSize: CGSize) {
        self.size = forSize
        let centerAngle = -90.0 * .pi / 180.0
        startAngle = centerAngle - completeAngle/2
        endAngle   = centerAngle + completeAngle/2
        midAngle   = startAngle+(endAngle-startAngle)*0.7
        thinLine = self.size.width / 320
        thickLine = thickLineFactor * thinLine
        borderLine = 2.0 * thinLine
        radius1 = size.height * 0.95
        radius2 = radius1 * 1.07
        radius3 = radius2 * 1.045

        let r = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        displayCenter = CGPoint(x: r.midX, y: r.origin.y + 1.2 * r.size.height)

        let w = thickLine
        let h = radius2 + thickLine
        needleYOffset = displayCenter.y - h + 2 * w / 3
    }
}
