//
//  Stamp.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 08/09/2021.
//

import SwiftUI

// TODO: do not use a global
var sizeAfterRotation: CGSize = CGSize(width: 200, height: 200)

struct Stamp: View {
    var text: String
    var color: Color
    var angle: Angle = Angle(degrees: -25.0)
    @State var totalSize: CGSize = CGSize(width: 100, height: 100)

    private let fontSize:CGFloat = 30.0
    
    var body: some View {
        let _ = print("totalSize=\(totalSize.format())")
        ZStack {
            Rectangle()
                .foregroundColor(.blue)
                .stampCaptureSize(in: $totalSize)
            RotatedStampText(
                text: text,
                color: color,
                fontSize: fontSize,
                angle: angle)
                .background(Color.green.opacity(0.2))
                .scaleEffect(min(totalSize.width / sizeAfterRotation.width, totalSize.height / sizeAfterRotation.height))
        }
    }

    struct RotatedStampText: View {
        var text: String
        var color: Color
        let fontSize:CGFloat
        let angle: Angle
        @State var size: CGSize = CGSize(width: 100, height: 100)
        var body: some View {
            let _ = print("sizeAfterRotation=\(sizeAfterRotation)")
            let stampPadding = StampPadding(size, angle: angle)
            HorizontalStamp(text: text, color: color, fontSize: fontSize)
                .stampCaptureSize(in: $size)
                .rotationEffect(angle)
                .padding(.leading,  stampPadding.horizontal)
                .padding(.trailing, stampPadding.horizontal)
                .padding(.top,      stampPadding.vertical)
                .padding(.bottom,   stampPadding.vertical)
        }
    }
    
    struct HorizontalStamp: View {
        var text: String
        var color: Color
        let fontSize:CGFloat
        
        var body: some View {
            let margin      = fontSize * 0.4
            let borderWidth = fontSize * 0.4
            Text(text)
                .foregroundColor(color)
                .font(.system(size: fontSize))
                .lineLimit(1)
                .padding(margin)
                .padding(borderWidth/2)
                .overlay(
                    RoundedRectangle(
                        cornerRadius: borderWidth*1.5)
                        .stroke(color, lineWidth: borderWidth))
                .padding(borderWidth/2)
                .background(Color.green.opacity(0.2))
            
        }
    }
}

struct StampPadding {
    let horizontal: CGFloat
    let vertical: CGFloat

    init(_ size: CGSize, angle: Angle) {
        // see rectangleRotation.pptx for the math
        let A1 = size.width
        let B1 = size.height
        let alpha = CGFloat(abs(angle.radians))

        let A21 = B1 * sin(alpha)
        let A22 = A1 * cos(alpha)
        let A2 = A21 + A22

        let B21 = A1 * sin(alpha)
        let B22 = B1 * cos(alpha)
        let B2 = B21 + B22

        let widthScale  = (A2 / A1) - 1.0
        let heightScale = (B2 / B1) - 1.0
        horizontal = 0.5*widthScale*A1
        vertical = 0.5*heightScale*B1
        sizeAfterRotation = CGSize(
            width:  size.width  + 2*horizontal,
            height: size.height + 2*vertical)
    }
}

struct Stamp_Previews: PreviewProvider {
    static var previews: some View {
        Stamp(
            text: "Éjsdf",
            color: C.color.bullshitRed)
            .frame(width: 350, height: 350, alignment: .center)
//            .background(Color.yellow.opacity(0.2))
            .border(Color.black)
    }
}



