//
//  StampViewModel.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 08/09/2021.
//

import Foundation
import SwiftUI

class StampViewModel: ObservableObject {
    @Published var marginCGFloat: CGFloat = 0.0
    @Published var borderWidthCGFloat: CGFloat = 0.0
    @Published var scaleCGFloat: CGFloat = 0.3
    @Published var rotationScaleCGFloat: CGFloat = 0.3
    let top: String
    let bottom: String?
    let color: Color
    
    var angleInDegrees: Double = -25.0 * .pi / 180.0 {
        didSet {
            setAngle(angleInDegrees: angleInDegrees)
        }
    }

    var frameWidthCGFloat: CGFloat = 100 {
        didSet {
            setSize(width: frameWidthCGFloat, height: frameHeightCGFloat)
        }
    }
    var frameHeightCGFloat: CGFloat = 100 {
        didSet {
            setSize(width: frameWidthCGFloat, height: frameHeightCGFloat)
        }
    }
    
    private var textSizeWidth: Double = 100
    private var textSizeHeight: Double = 100
    var rotationAngle = 0.0
    private var frameWidth: Double = 100
    private var frameHeight: Double = 100
    private var margin: Double = 0.0
    private var borderThickness: Double = 0.0
    private var scale: Double = 0.0

    private let marginFactor = 0.05
    private let borderWidthFactor = 0.25

    init(top: String, bottom: String?, rotated: Bool, color: Color) {
        self.top = top
        self.bottom = bottom
        self.color = color
        setTextSize(CGSize(width: frameWidth, height: frameHeight))
    }

    func setSize(width: CGFloat, height: CGFloat) {
        self.frameWidth = Double(width)
        self.frameHeight = Double(height)
        calc()
    }
    
    func setTextSize(_ textSize: CGSize) {
        textSizeWidth = Double(textSize.width)
        textSizeHeight = Double(textSize.height)
        calc()
    }

    func setAngle(angleInDegrees: Double) {
        rotationAngle = angleInDegrees * .pi / 180.0
        calc()
    }
    func calc() {
        margin = textSizeHeight * marginFactor
        borderThickness = textSizeHeight * borderWidthFactor
        let textWithBorderWidth = textSizeWidth+margin*2+borderThickness*2
        let textWithBorderHeight = textSizeHeight+margin*2+borderThickness*2
        let scaleW = frameWidth / textWithBorderWidth
        let scaleH = frameHeight / textWithBorderHeight
        scale = 1.0//min(scaleW, scaleH)
        
        marginCGFloat = CGFloat(margin)
        borderWidthCGFloat = CGFloat(borderThickness)
        scaleCGFloat = CGFloat(scale)
        
        // see rectangleRotation.pptx for the math
        let A1 = textWithBorderWidth
        let B1 = textWithBorderHeight
        let alpha = abs(rotationAngle)

        let beta = atan(B1/A1)
        let term1 = sin(alpha + beta)
        let term2 = sqrt(A1*A1+B1*B1)
        let B2 = term1 * term2

        let A21 = B1 * sin(alpha)
        let A22 = A1 * cos(alpha)
        let A2 = A21 + A22

        // sticking out at the top and bottom?
        let stickingOutAtTopAnDBottomFactor = B1 / B2 * scaleH

        // sticking out at the sides?
        let stickingOutAtSidesFactor = A1 / A2 * scaleW
    
        let rotationScaleFactor = min(stickingOutAtTopAnDBottomFactor, stickingOutAtSidesFactor)

        rotationScaleCGFloat = CGFloat(rotationScaleFactor)
    }
}