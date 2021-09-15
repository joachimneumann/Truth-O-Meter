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
    let expandedTextSize: CGSize
    init(frameSize: CGSize, textSize: CGSize, angle: Angle) {
        let marginFactor = 0.4
        let borderWidthFactor = 0.25
        assert(borderWidthFactor <= marginFactor)
        // border is inside the margin, see rectangleRotation.pptx
        
        let tw = textSize.width
        let th = textSize.height
        
        let m = th * marginFactor
        let twm = tw + 2.0*m
        let thm = th + 2.0*m
        
        let fw = frameSize.width
        let fh = frameSize.height
        
        
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
        
        expandedTextSize = CGSize(
            width:  twr - 2 * offset,
            height: thr - 2 * offset)
        
        let sw = fw / expandedTextSize.width
        let sh = fh / expandedTextSize.height
        
        scale = min(sw, sh)
    }
}

struct StampView: View {
    let firstLine: String
    let secondLine: String?
    let color: Color
    let angle: Angle
    @State var frameSize = CGSize(width: 1.0, height: 1.0)
    @State var textSize  = CGSize(width: 1.0, height: 1.0)
    
    let largeFontSize = 300.0
    
    init(
        _ firstLine: String,
        _ secondLine: String? = nil,
        color: Color = Color(red: 255.0/255.0, green: 83.0/255.0, blue: 77.0/255.0),
        angle: Angle = Angle(degrees: -25)
    ) {
        self.firstLine = firstLine
        self.secondLine = secondLine
        self.color = color
        self.angle = angle
    }
    
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
                            VStack {
                                Text(firstLine)
                                if let secondLine = secondLine {
                                    Text(secondLine)
                                }
                            }
                                .font(.system(size: largeFontSize).bold())
                                .foregroundColor(color)
                                .fixedSize()
                                .lineLimit(1)
                                //.background(Color.red.opacity(0.2))
                                .captureSize(in: $textSize)
                                .padding(calc.padding-calc.borderWidth/2)
                                .overlay(
                                    RoundedRectangle(cornerRadius: calc.cornerRadius)
                                        .stroke(color, lineWidth: calc.borderWidth))
                                .padding(calc.borderWidth/2)
                        )
                        .mask(Image(uiImage: UIImage(named: "mask")!)
                                .resizable()
                                .scaledToFill()
                                .frame(width: calc.expandedTextSize.width, height: calc.expandedTextSize.height, alignment: SwiftUI.Alignment.center)
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
        StampView("Stamp Text")
            .frame(width: 330, height: 400, alignment: .center)
    }
}
