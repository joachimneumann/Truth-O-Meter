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
    let borderWidth: Double
    let cornerRadius: Double
    let scale: Double
    init(frameSize: CGSize, textSize: CGSize, angle: Angle) {
        let marginFactor = 0.4
        let borderWidthFactor = 0.3

        let tw = textSize.width
        let th = textSize.height
        
        let m = th * marginFactor
        let twm = tw + 2.0*m
        let thm = th + 2.0*m

        let fw = frameSize.width
        let fh = frameSize.height
        
        
        assert(borderWidthFactor <= marginFactor)
        // border is inside the margin

        let b = th * borderWidthFactor
        let alpha = abs(angle.radians)
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
        let beta2 = Angle.degrees(45).radians - abs(angle.radians)
        let offset = outerCornerRadius * ( sqrt(2.0) * cos(beta2) - 1.0)

        let sw = fw / (twr - 2*offset)
        let sh = fh / (thr - 2*offset)


        scale = min(sw, sh)
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
                                .padding(calc.padding-calc.borderWidth/2)
                                .overlay(
                                    RoundedRectangle(cornerRadius: calc.cornerRadius)
                                        .stroke(color, lineWidth: calc.borderWidth))
                                .padding(calc.borderWidth/2)
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
