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
    var body: some View {
        HorizontalStampText(
            text: text,
            color: color)
    }
    
//    struct BorderedHorizontalStampText: View {
//        @State var frameSize = CGSize(width: 100, height: 100)
//        @State var largeTextSize = CGSize(width: 100, height: 100)
//        @State var actualTextSize = CGSize(width: 100, height: 100)
//        private let marginFactor: CGFloat = 0.05
//        var margin: Binding<CGFloat> {
//            return $frameSize.height// * borderLineWidthFactor
//        }
//        var text: String
//        var color: Color
//        var body: some View {
//            HorizontalStampText(
//                text: text,
//                color: color,
//                frameSize: $frameSize,
//                largeTextSize: $largeTextSize,
//                actualTextSize: $actualTextSize
//            )
//            .padding($actualTextSize.wrappedValue.height*marginFactor)
//        }
//    }
    
    struct HorizontalStampText: View {
        var text: String
        var color: Color
        let largeFontSize:CGFloat = 300
        @State var frameSize = CGSize(width: 100, height: 100)
        @State var largeTextSize = CGSize(width: 100, height: 100)
        var scaleFactor: CGFloat {
            let _scaleFactorWidth = frameSize.width / largeTextSize.width
            let _scaleFactorHeight = frameSize.height / largeTextSize.height
            return min(_scaleFactorWidth, _scaleFactorHeight)
        }
        
        var body: some View {
            ZStack {
                Rectangle()
                    .foregroundColor(.blue.opacity(0.2))
                    .stampCaptureSize(in: $frameSize)
                    .background(
                        ZStack {
                            Text(text)
                                .background(Color.blue.opacity(0.2))
                                .font(.system(size: largeFontSize))
                                .fixedSize()
                                .stampCaptureSize(in: $largeTextSize)
                                .hidden()
                            Text(text)
                                .foregroundColor(color)
                                .font(.system(size: largeFontSize))
                                .fixedSize()
                                .background(Color.green)
                                .scaleEffect(scaleFactor, anchor: .center)
                        }
                    )
            }
        }
    }
}

struct Stamp_Previews: PreviewProvider {
    static var previews: some View {
        Stamp(
            text: "Éjsdf",
            color: C.color.bullshitRed)
            .frame(width: 350, height: 350, alignment: .center)
            .background(Color.yellow.opacity(0.2))
            .border(Color.black)
    }
}



