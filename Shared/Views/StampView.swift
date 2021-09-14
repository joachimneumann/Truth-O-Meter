//
//  StampView.swift
//  StampView
//
//  Created by Joachim Neumann on 13/09/2021.
//

import SwiftUI

var textCaptured = false
var frameCaptured = false

struct StampView: View {
    let top: String
    let largeFontSize = 100.0
    @State var frameSize = CGSize(width: 1.0, height: 1.0)
    @State var textSize  = CGSize(width: 1.0, height: 1.0)
    @State var frameCapturedBinding = false
    @State var textCapturedBinding = false

    let debugInfo = false
    var body: some View {

        let scaleHorizontal = frameSize.width / textSize.width
        let borderwidth = 0.5
        let margin = borderwidth + 0.25
        let marginFactor = textSize.width / (textSize.width + 2.0 * margin * textSize.height)
        let scale = scaleHorizontal * marginFactor
        ZStack {
            if true{//}!frameCaptured {
                Rectangle()
                    .foregroundColor(.clear)//.blue.opacity(0.2))
                    .background(
                        Rectangle()
                            .foregroundColor(.clear)
                            .captureSize(in: $frameSize, description: "frame", captured: &frameCaptured, capturedBinding: $frameCapturedBinding)
                    )
            }
            //let _ = print("StampView VStack scaleHorizontal = \(scaleHorizontal.s) frameSize = \(frameSize) textSize = \(textSize)")
            let _ = print("StampView VStack frameSize = \(frameSize) textSize = \(textSize) fc \(frameCaptured) \(frameCapturedBinding) tc \(textCaptured) \(textCapturedBinding)")
            if true { //}!frameCaptured || !textCaptured {
                VStack {
                    let _ = print("StampView VStack")
                    ZStack {
                        Rectangle()
                            .foregroundColor(.clear)//green.opacity(0.2))
                            .background(
                                Text(top)
                                    .font(.system(size: largeFontSize))
                                    .fixedSize()
                                    .lineLimit(1)
                                    .captureSize(in: $textSize, description: "text", captured: &textCaptured, capturedBinding: $textCapturedBinding)
                                    .padding(textSize.height*margin)
//                                    .padding(textSize.height*margin)
                                    //.animation(.linear(duration: 0.0))
                                    .background(Color.green.opacity(0.2))
                            )
                    }
                    .fixedSize(horizontal: true, vertical: true)
                }
                .scaleEffect(scale)
            } else {
//                Text("done")
                VStack {
                    ZStack {
                        GeometryReader { geo in
                                Text("xx")
                        }
//                        Rectangle()
//                            .foregroundColor(.clear)//green.opacity(0.2))
//                            .background(
//                                Text(top)
//                                    .font(.system(size: largeFontSize))
//                                    .fixedSize()
//                                    .lineLimit(1)
//                                    .background(Color.pink.opacity(0.2))
//                                    .padding(textSize.height*margin)
//                                    .border(Color.green, width: textSize.height*borderwidth)
//                                    .scaleEffect(scale)
////                                    .rotationEffect(Angle(degrees: 0))
//                            )
                        /// A rectangle that fills the frame
                        /// The fixedSize modifier foreces the Text and this Rectangle to be the same size
                        /// In order to make the Text follow the Rectangle and not the other way round
                        /// I set the frame of the Rectangle to the previously captured frameSize
                        Rectangle()
                            .foregroundColor(.yellow.opacity(0.2))
                            .frame(width: frameSize.width, height: frameSize.height)
                    }
//                    .fixedSize(horizontal: true, vertical: true)
                }
            }
        }
    }
}

struct StampView_Previews: PreviewProvider {
    static var previews: some View {
        StampView(top: "Bullshit")
    }
}
