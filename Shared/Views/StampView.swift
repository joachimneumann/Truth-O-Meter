//
//  Stamp.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 21/08/2021.
//

import SwiftUI


struct StampView: View {
    let top: String
    let bottom: String?
    let rotated: Bool
    var body: some View {
        // we do not want texts that are only one or two characters long
        // In this case, we pad with a space to the left and right
        let _top    = top.count    < 3 ? " \(top) " : top
        let _bottom = bottom == nil ? nil : (bottom!.count < 3 ? " \(bottom!) " : bottom!)
        // TODO:
        // Stangely, for bottom = "BB" the trailing space
        // is not shown in the stamp
        return Group {
            VStack {
                HStack {
                    Spacer(minLength: 0)
                }
                Spacer(minLength: 0)
                HStack {
                    Spacer(minLength: 0)
                    if _top == "" && (_bottom == "" || _bottom == nil) {
                        OneLine("(not set)", angle: rotated ? -25.0 : 0.0)
                    } else if let b = _bottom {
                        if _top != "" {
                            TwoLines(_top, b, angle: rotated ? -18.0 : 0.0)
                        } else {
                            OneLine(b, angle: rotated ? -25.0 : 0.0)
                        }
                    } else {
                        OneLine(_top, angle: rotated ? -25.0 : 0.0)
                    }
                    Spacer(minLength: 0)
                }
                Spacer(minLength: 0)
            }
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
    @EnvironmentObject private var settings: Settings
    var text1: String
    var text2: String
    var rotationAngle:Double
    var body: some View {
        var f:CGFloat
        let textCount = max(text1.count, text2.count)
        let numberOfLetters: CGFloat = CGFloat(textCount) + 2.0
        if textCount < 6 { f = 0.3 } else
        { f = 2.2 / numberOfLetters }
        let fontsize = settings.w * f
        let linewidth = fontsize * 0.24
        let text = text1+"\n"+text2
        //        let linewidth = w * 0.06
        //        let fontsize = w*0.25
        return Text(text)
            .lineLimit(2)
            .fixedSize(horizontal: true, vertical: true)
            .font(.system(size: fontsize, weight: .bold, design: .monospaced))
            .padding(fontsize*0.3)
            .overlay(RoundedRectangle(cornerRadius: linewidth*1.5)
                        .stroke(C.color.bullshitRed, lineWidth: linewidth))
            .foregroundColor(C.color.bullshitRed)
            .padding(linewidth/2)
            .mask(Mask())
            .rotationEffect(Angle(degrees: rotationAngle))
    }
    init(_ t1: String, _ t2: String, angle: Double) {
        text1 = t1
        text2 = t2
        rotationAngle = angle
    }
}

struct OneLine: View {
    @EnvironmentObject private var settings: Settings
    var text: String
    var rotationAngle: Double
    var body: some View {
        var f:CGFloat
        let numberOfLetters: CGFloat = CGFloat(text.count) + 2.0
        if text.count == 1 { f = 0.48 } else
        if text.count == 2 { f = 0.45 } else
        { f = 2.2 / numberOfLetters }
        let fontsize = settings.w * f
        let linewidth = fontsize * 0.24
        return Text(text)
            .fixedSize(horizontal: true, vertical: true)
            .font(.system(size: fontsize, weight: .bold, design: .monospaced))
            .padding(fontsize*0.3)
            .overlay(RoundedRectangle(cornerRadius: linewidth*1.5)
                        .stroke(C.color.bullshitRed, lineWidth: linewidth))
            .foregroundColor(C.color.bullshitRed)
            .padding(linewidth/2)
            .mask(Mask())
            .rotationEffect(Angle(degrees: rotationAngle))
    }
    init(_ t: String, angle: Double) { text = t; rotationAngle = angle }
}

struct Stamp_Previews: PreviewProvider {
    static var previews: some View {
        StampView(top: "1", bottom: nil, rotated: false)
            .background(Color.yellow)
            .aspectRatio(1.3, contentMode: .fit)
        StampView(top: "A", bottom: "BB", rotated: false)
            .background(Color.yellow)
            .aspectRatio(1.3, contentMode: .fit)
    }
}
