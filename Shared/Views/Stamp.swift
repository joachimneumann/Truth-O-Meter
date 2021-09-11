//
//  Stamp.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 08/09/2021.
//

import SwiftUI

struct Stamp: View {
    var text: String
    var color: Color
    let fontSize:CGFloat
    var angle: Angle

    @State var size: CGSize = CGSize(width: 100, height: 100)

    var body: some View {
        let margin      = fontSize * 0.4
        let borderWidth = fontSize * 0.4
        let stampPadding = StampPadding(size, angle: angle)
        Text(text)
            .foregroundColor(color)
            .font(.system(size: 100, weight: .bold))
            .minimumScaleFactor(0.01)
//            .font(.system(size: fontSize))
            .lineLimit(1)
            .padding(margin)
            .padding(borderWidth/2)
            .overlay(
                RoundedRectangle(
                    cornerRadius: borderWidth*1.5)
                    .stroke(color, lineWidth: borderWidth))
            .padding(borderWidth/2)
            .background(Color.green.opacity(0.2))
            .stampCaptureSize(in: $size)
            .rotationEffect(angle)
            .padding(.leading,  stampPadding.horizontal)
            .padding(.trailing, stampPadding.horizontal)
            .padding(.top,      stampPadding.vertical)
            .padding(.bottom,   stampPadding.vertical)
            .background(Color.green.opacity(0.2))
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
    }
}

struct Stamp_Previews: PreviewProvider {
    static var previews: some View {
        Stamp(
            text: "Éjssdfsdfsdsdfsdfsdfsdfsdf",
            color: C.color.bullshitRed,
            fontSize: 30,
            angle: Angle(degrees: -25.0))
    }
}


extension Double {
    var f: String {
        return String(format:"%7.3f", self)
    }
}

extension CGFloat {
    var f: String {
        return String(format:"%7.3f", self)
    }
}
