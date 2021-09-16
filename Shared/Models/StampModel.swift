//
//  StampModel.swift
//  Truth-O-Meter (iOS)
//
//  Created by Joachim Neumann on 15/09/2021.
//

import CoreGraphics

struct StampModel {
    let padding: Double
    let borderWidth: Double
    let cornerRadius: Double
    let scale: Double
    let maskSize: CGSize
    let largeFontSize = 300.0
    
    init(frameSize: CGSize, textSize: CGSize, angle: Double) {
        
        ///
        /// for the math, see rectangleRotation.pptx
        ///
        
        let marginFactor: Double = 0.4
        let borderWidthFactor: Double = 0.25
        
        /// assert that border is smaller than the marding,
        /// because the border is drawn inside the margin
        assert(borderWidthFactor <= marginFactor)
        
        let tw: Double = textSize.width
        let th: Double = textSize.height
        
        let m: Double = th * marginFactor
        let twm: Double = tw + 2.0 * m
        let thm: Double = th + 2.0 * m
        
        let fw: Double = frameSize.width
        let fh: Double = frameSize.height
        
        
        let b:Double = th * borderWidthFactor
        let alpha:Double = angle > 0 ? angle : -angle
        var temp: Double = thm / twm
        let beta:Double = atan( temp )
        let d: Double = sqrt(twm*twm+thm*thm)
        temp = alpha+beta
        let thr: Double = sin(temp)*d
        
        let twr1: Double = sin(alpha)*thm
        let twr2: Double = cos(alpha)*twm
        let twr: Double = twr1 + twr2
        
        padding = m
        borderWidth = b
        cornerRadius = 1.5*b
        
        let outerCornerRadius: Double = cornerRadius + 0.5 * borderWidth
        let beta2: Double = (45.0 * .pi / 180.0) - abs(angle)
        let offset: Double = outerCornerRadius * ( sqrt(2.0) * cos(beta2) - 1.0)
        
        let sw: Double = fw / (twr - 2 * offset)
        let sh: Double = fh / (thr - 2 * offset)
        
        /// set the mask size large
        /// this alloes me to handle single characters
        /// with angles like 80 degrees
        maskSize = CGSize(
            width:  max(twr, thr),
            height: max(twr, thr))
        scale = min(sw, sh)
    }
}
