//
//  StampViewModel.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 08/09/2021.
//

import Foundation
import SwiftUI

class StampViewModel: ObservableObject {
    let top: String
    let bottom: String?
    let rotated: Bool
    let color: Color
    var widthCGFloat: CGFloat = 100 {
        didSet {
            // print(widthCGFloat)
            setSize(width: widthCGFloat, height: heightCGFloat)
        }
    }
    var heightCGFloat: CGFloat = 100 {
        didSet {
            // print(heightCGFloat)
            setSize(width: widthCGFloat, height: heightCGFloat)
        }
    }
    var textSizeWidth: Double = 100
    var textSizeHeight: Double = 100
    var width: Double = 100
    var height: Double = 100
    private var margin: Double = 0.0
    private var borderWidth: Double = 0.0
    private var scale: Double = 0.0
    @Published var marginCGFloat: CGFloat = 0.0
    @Published var borderWidthCGFloat: CGFloat = 0.0
    @Published var scaleCGFloat: CGFloat = 0.3

    private let marginFactor = 0.25
    private let borderWidthFactor = 0.25

    init(top: String, bottom: String?, rotated: Bool, color: Color) {
        self.top = top
        self.bottom = bottom
        self.rotated = rotated
        self.color = color
        setTextSize(CGSize(width: width, height: height))
    }

    func setSize(width: CGFloat, height: CGFloat) {
        self.width = Double(width)
        self.height = Double(height)
        calc()
    }
    
    func setTextSize(_ textSize: CGSize) {
        textSizeWidth = Double(textSize.width)
        textSizeHeight = Double(textSize.height)
        calc()
    }

    func calc() {
        margin = height * marginFactor
        borderWidth = height * borderWidthFactor
        let scaleW = height/(textSizeHeight)//+margin*2+borderWidth*2)
        let scaleH = width/(textSizeWidth)//+margin*2+borderWidth*2)
        scale = min(scaleW, scaleH)
        
        marginCGFloat = CGFloat(margin)
        borderWidthCGFloat = CGFloat(borderWidth)
        scaleCGFloat = CGFloat(scale)
    }
}
