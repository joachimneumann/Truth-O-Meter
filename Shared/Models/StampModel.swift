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
        
        let alpha:Float = max(angle, -angle)

        let m: Float = th * marginFactor
        let twm: Float = tw + 2.0 * m
        let thm: Float = th + 2.0 * m
        
        let b:Float = th * borderWidthFactor
        let beta:Float = atan( thm / twm )
        let thr: Float = sin(alpha+beta) * sqrt(twm*twm+thm*thm)
        let twr: Float = sin(alpha)*thm + cos(alpha)*twm
        
        let outerCornerRadius: Float = Float(1.5) * b + Float(0.5) * b
        let beta2: Float = (Float(45.0) * Float.pi / Float(180.0)) - alpha
        let offset: Float = outerCornerRadius * ( sqrt(Float(2.0)) * cos(beta2) - Float(1.0))
        
        let sw: Float = fw / (twr - Float(2.0) * offset)
        let sh: Float = fh / (thr - Float(2.0) * offset)
        
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
