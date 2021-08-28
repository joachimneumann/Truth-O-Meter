//
//  Stamp.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 21/08/2021.
//

import SwiftUI

struct Stamp: View {
    var texts: Result
    var rotated = true
    var body: some View {
        if let bottom = texts.bottom {
            return AnyView(TwoLines(texts.top+"\n"+bottom, rotated ? -18.0 : 0.0))
        } else {
            return AnyView(OneLine(texts.top, rotated ? -25.0 : 0.0))
        }
    }
}

struct Mask: View {
    var body: some View {
        Image(cpImage: CPImage(named: "mask")!)
            .resizable()
            .scaledToFill()
    }
}

struct TwoLines: View {
    var text: String
    var rotationAngle:Double
    var body: some View {
        return Text(text)
            .padding(10)
            .font(.system(size: 500, weight: .bold))
            .minimumScaleFactor(0.01)
            .multilineTextAlignment(.center)
            .lineSpacing(0)
            .foregroundColor(C.Colors.bullshitRed)
            .lineLimit(2)
            .padding(10)
            .overlay(RoundedRectangle(cornerRadius: 20)
                .stroke(C.Colors.bullshitRed, lineWidth: 6))
            .padding(25)
            .mask(Mask())
            .rotationEffect(Angle(degrees: rotationAngle))
    }
    init(_ t: String, _ angle: Double) { text = t; rotationAngle = angle }
}

struct OneLine: View {
    var text: String
    var rotationAngle: Double
    var body: some View {
        return Text(text)
            .padding(15)
            .font(.system(size: 500, weight: .bold))
            .minimumScaleFactor(0.01)
            .foregroundColor(C.Colors.bullshitRed)
            .lineLimit(1)
            .overlay(RoundedRectangle(cornerRadius: 20)
                .stroke(C.Colors.bullshitRed, lineWidth: 6))
            .padding(10)
            .mask(Mask())
            .rotationEffect(Angle(degrees: rotationAngle))
    }
    init(_ t: String, _ angle: Double) { text = t; rotationAngle = angle }
}

struct Stamp_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Spacer()
            Stamp(texts: Result("Absolute", "Bullshit"))
                .background(Color.yellow)
            Spacer()
        }
    }
}
