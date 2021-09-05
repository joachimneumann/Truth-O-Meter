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
    let color: Color
    
    var body: some View {
        // we do not want texts that are only one or two characters long
        // In this case, we pad with a space to the left and right
        var _top: String
        if top.count == 1 {_top = "    \(top)    " } else
        if top.count == 2 {_top = "  \(top)  " } else
        if top.count == 3 {_top = " \(top) " } else { _top = top }
        let _bottom = bottom == nil ? nil : (bottom!.count < 3 ? " \(bottom!) " : bottom!)
        // TODO:
        // Stangely, for bottom = "BB" the trailing space
        // is not shown in the stamp
        //            VStack {
        //                HStack {
        //                    Spacer(minLength: 0)
        //                }
        //                Spacer(minLength: 0)
        //                HStack {
        //                    Spacer(minLength: 0)
        return ZStack {
            if _top == "" && (_bottom == "" || _bottom == nil) {
                OneLine(
                    text: "(not set)",
                    rotationAngle: rotated ? -25.0 : 0.0,
                    color: color)
            } else if let b = _bottom {
                if _top != "" {
                    TwoLines(
                        text1: _top,
                        text2: b,
                        rotationAngle: rotated ? -18.0 : 0.0,
                        color: color)
                } else {
                    OneLine(
                        text: b,
                        rotationAngle: rotated ? -25.0 : 0.0,
                        color: color)
                }
            } else {
                OneLine(
                    text: _top,
                    rotationAngle: rotated ? -25.0 : 0.0,
                    color: color)
        }

        }
        //                    Spacer(minLength: 0)
        //                }
        //                Spacer(minLength: 0)
        //            }
        //        }
    }
    
    struct OneLine: View {
        var text: String
        var rotationAngle: Double
        var color: Color
        var body: some View {
            let linewidth = 0.15 * C.w / sqrt(CGFloat(text.count))
            var hpadding:CGFloat = 0.05
            if (rotationAngle < 0) && (text.count < 6) {
                hpadding *= 2
            }
            print(rotationAngle)
            print(hpadding)
            return GeometryReader { geo in
                let w = geo.size.width
                VStack {
                    Spacer(minLength: 0)
                    HStack {
                        Spacer(minLength: 0)
                        Text(text)
                            .lineLimit(1)
                            .foregroundColor(color)
                            .font(.system(size: 500).bold())
                            .minimumScaleFactor(0.01)
                            .padding(.leading, w*hpadding)
                            .padding(.trailing, w*hpadding)
                            .padding(.top, w*0.05)
                            .padding(.bottom, w*0.05)
                            .overlay(RoundedRectangle(cornerRadius: linewidth*1.5)
                                        .stroke(color, lineWidth: linewidth))
                            .padding(.leading, w*hpadding)
                            .padding(.trailing, w*hpadding)
                            .mask(MaskView())
                            .background(Color.gray)
                        Spacer(minLength: 0)
                    }
                    Spacer(minLength: 0)
                }
            }
            .rotationEffect(Angle(degrees: rotationAngle))
            .contentShape(Rectangle())
            .aspectRatio(1.3, contentMode: .fit)
        }
    }
    
    struct TwoLines: View {
        var text1: String
        var text2: String
        var rotationAngle:Double
        var color: Color
        var body: some View {
            var f:CGFloat
            let textCount = max(text1.count, text2.count)
            let numberOfLetters: CGFloat = CGFloat(textCount) + 2.0
            if textCount < 6 { f = 0.3 } else
            { f = 2.2 / numberOfLetters }
            let fontsize = C.w * f
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
                .foregroundColor(color)
                .padding(linewidth/2)
                .mask(MaskView())
                .rotationEffect(Angle(degrees: rotationAngle))
        }
    }
    
}

struct Stamp_Previews: PreviewProvider {
    static var previews: some View {
        StampView(top: "Dii", bottom: nil, rotated: true, color: Color.blue)
            .background(Color.yellow)
        //        StampView(top: "A", bottom: "BBb", rotated: false)
        //            .background(Color.yellow)
    }
}
