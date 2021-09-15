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
    init(frameSize: CGSize, textSize: CGSize, angle: Double) {
        
        ///
        /// for the math, see rectangleRotation.pptx
        ///
        
        let marginFactor = 0.4
        let borderWidthFactor = 0.25
        
        /// assert that border is smaller than the marding,
        /// because the border is drawn inside the margin
        assert(borderWidthFactor <= marginFactor)
        
        let tw = textSize.width
        let th = textSize.height
        
        let m = th * marginFactor
        let twm = tw + 2.0*m
        let thm = th + 2.0*m
        
        let fw = frameSize.width
        let fh = frameSize.height
        
        
        let b = th * borderWidthFactor
        let alpha = abs(angle)
        let beta = atan(thm/twm)
        let d = sqrt(twm*twm+thm*thm)
        
        let thr = sin(alpha+beta)*d
        
        let twr1 = sin(alpha)*thm
        let twr2 = cos(alpha)*twm
        let twr = twr1 + twr2
        
        padding = m
        borderWidth = b
        cornerRadius = 1.5*b
        
        let outerCornerRadius = cornerRadius + 0.5 * borderWidth
        let beta2 = (45.0 * .pi / 180.0) - abs(angle)
        let offset = outerCornerRadius * ( sqrt(2.0) * cos(beta2) - 1.0)
        
        let sw = fw / (twr - 2 * offset)
        let sh = fh / (thr - 2 * offset)
        
        /// set the mask size large
        /// this alloes me to handle single characters
        /// with angles like 80 degrees
        maskSize = CGSize(
            width:  max(twr, thr),
            height: max(twr, thr))
        scale = min(sw, sh)
    }
}
