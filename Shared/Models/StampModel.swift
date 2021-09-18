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
    let maskSize: Double
    let largeFontSize = 300.0
    
    init(fw: Float, fh: Float, tw: Float, th: Float, angle: Float) {
        
        ///
        /// for the math, see rectangleRotation.pptx
        ///
        
        /// swift is very slow to compile Double atan, etc. Float precision is sufficient here

        
        let marginFactor: Float = 0.4
        let borderWidthFactor: Float = 0.25
        
        /// assert that border is smaller than the marding,
        /// because the border is drawn inside the margin
        assert(borderWidthFactor <= marginFactor)
        
        let alpha:Float = angle > 0 ? Float(angle) : Float(-angle)

        let m: Float = th * marginFactor
        let twm: Float = tw + 2.0 * m
        let thm: Float = th + 2.0 * m
        
        let b:Float = th * borderWidthFactor
        var temp: Float = thm / twm
        let beta:Float = atan( temp )
        let d: Float = sqrt(twm*twm+thm*thm)
        temp = alpha+beta
        let thr: Float = sin(temp)*d
        
        let twr1: Float = sin(alpha)*thm
        let twr2: Float = cos(alpha)*twm
        let twr: Float = twr1 + twr2
        
        
        let outerCornerRadius: Float = (1.5*b) + 0.5 * (b)
        let beta2: Float = (45.0 * Float.pi / 180.0) - abs(alpha)
        let offset: Float = outerCornerRadius * ( sqrt(2.0) * cos(beta2) - 1.0)
        
        let sw: Float = fw / (twr - 2 * offset)
        let sh: Float = fh / (thr - 2 * offset)
        
        /// set the mask size large
        /// this allows me to handle single characters
        /// with angles like 80 degrees
        padding = Double(m)
        borderWidth = Double(b)
        cornerRadius = Double(1.5*b)
        maskSize = Double(max(twr, thr))
        scale = Double(min(sw, sh))
    }
}
