//
//  StampView.swift
//  StampView
//
//  Created by Joachim Neumann on 13/09/2021.
//

import SwiftUI

var textCaptured = false
var frameCaptured = false

struct FrameCatcher: View {
    @Binding var into: CGSize
    var body: some View {
        Rectangle()
            .foregroundColor(.clear)//.blue.opacity(0.2))
            .background(
                Rectangle()
                    .foregroundColor(.clear)
                    .captureSize(in: $into)
            )
    }
}

struct Calc {
    let padding: Double
    let borderwidth: Double
    let cornerRadius: Double
    let scale: Double
    init(frameSize: CGSize, textSize: CGSize, angle: Angle) {
        let marginFactor = 0.2
        let borderWidthFactor = 0.1

        let tw = textSize.width
        let th = textSize.height
        
        let m = th * marginFactor
        let twm = tw + 2.0*m
        let thm = th + 2.0*m

        let fw = frameSize.width
        let fh = frameSize.height
        
        let sw = fw / twm
        let sh = fh / thm
        
        assert(borderWidthFactor <= marginFactor)
        // border is inside the margin

        let b = th * borderWidthFactor
        let alpha = abs(angle.radians)
        let beta = atan(thm/twm)
        
        let thr = sin(alpha+beta)*sqrt(twm*twm+thm*thm)
        
        let rotationScalingFactor = thm/thr
        print("rotationScalingFactor \(rotationScalingFactor)")

        padding = m
        borderwidth = b
        cornerRadius = 1.5*b
        scale = min(sw, sh)*rotationScalingFactor
    }
}

struct StampView: View {
    let top: String
    let color: Color
    let angle: Angle
    @State var frameSize = CGSize(width: 1.0, height: 1.0)
    @State var textSize  = CGSize(width: 1.0, height: 1.0)
    
    let largeFontSize = 300.0
    
    var body: some View {
        
        let calc = Calc(frameSize: frameSize, textSize: textSize, angle: angle)
        
        ZStack {
            FrameCatcher(into: $frameSize)
            //let _ = print("frameSize = \(frameSize) textSize = \(textSize)")
            //let _ = print("scale \(calc.scale)")
            VStack {
                //let _ = print("StampView VStack")
                ZStack {
                    Rectangle()
                        .foregroundColor(.clear)//green.opacity(0.2))
                        .background(
                            Text(top)
                                .font(.system(size: largeFontSize))
                                .foregroundColor(color)
                                .fixedSize()
                                .lineLimit(1)
                                .captureSize(in: $textSize)
                                .padding(calc.padding-calc.borderwidth/2)
                                .overlay(
                                    RoundedRectangle(cornerRadius: calc.cornerRadius)
                                        .stroke(color, lineWidth: calc.borderwidth))
                                .padding(calc.borderwidth/2)
                                .background(Color.red.opacity(0.2))
                        )
                }
                .fixedSize(horizontal: true, vertical: true)
            }
            .scaleEffect(calc.scale)
            .rotationEffect(angle) // before or after scaling???
        }
    }
}

struct StampView_Previews: PreviewProvider {
    static var previews: some View {
        StampView(
            top: "iiiiiii",
            color: C.color.bullshitRed,
            angle: Angle(degrees: -25))
//            .background(Color.yellow)
            .frame(width: 330, height: 400, alignment: .center)
    }
}
