//
//  StampText.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 21/08/2021.
//

import SwiftUI

struct StampText: View {
    var line1: String
    var line2: String?
    var body: some View {
        print("StampText line1 = \(line1)")
        print("StampText line2 = \(line2)")
        if line2 == nil {
            return AnyView(OneLine(text: line1))
        } else {
            return AnyView(TwoLines(text1: line1, text2: line2!))
        }
    }
}

struct Mask: View {
    var body: some View {
        Image(uiImage: UIImage(named: "mask")!)
            .resizable()
            .scaledToFill()
    }
}

struct TwoLines: View {
    var text1: String
    var text2: String
    var body: some View {
        let text = text1+"\n"+text2
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
            .rotationEffect(Angle(degrees: -18))
    }
}

struct OneLine: View {
    var text: String
    var body: some View {
        print("OneLine \(text)")
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
            .rotationEffect(Angle(degrees: -25))
    }
}

struct StampText_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Spacer()
            StampText(line1: "Bullshit", line2: "Xxx")
            Spacer()
        }
    }
}
