//
//  Stamp.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 21/08/2021.
//

import SwiftUI

struct Stamp: View {
    var top: String
    var bottom: String?
    var rotated = true
    var body: some View {
        VStack {
            Spacer(minLength: 0)
            HStack {
                Spacer(minLength: 0)
                if top == "" && (bottom == "" || bottom == nil) {
                    OneLine("(not set)", rotated ? -25.0 : 0.0)
                } else if let b = bottom {
                    if top != "" {
                        TwoLines(top+"\n"+b, rotated ? -18.0 : 0.0)
                    } else {
                        OneLine(b, rotated ? -25.0 : 0.0)
                    }
                } else {
                    OneLine(top, rotated ? -25.0 : 0.0)
                }
                Spacer(minLength: 0)
            }
            Spacer(minLength: 0)
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
            .foregroundColor(C.color.bullshitRed)
            .lineLimit(2)
            .padding(10)
            .overlay(RoundedRectangle(cornerRadius: 20)
                        .stroke(C.color.bullshitRed, lineWidth: 6))
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
            .foregroundColor(C.color.bullshitRed)
            .lineLimit(1)
            .overlay(RoundedRectangle(cornerRadius: 20)
                        .stroke(C.color.bullshitRed, lineWidth: 6))
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
            Stamp(top: "top", bottom: "bottom", rotated: true)
                .background(Color.yellow)
            Spacer()
        }
    }
}
