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

//        let scale = frameSize.width / textSize.width
        let scaleHorizontal = frameSize.width / textSize.width
//        let borderwidth = 0.5
        let marginX = 0.4//borderwidth + 0.25
        let marginFactor = textSize.width / (textSize.width + 2.0 * marginX * textSize.height)
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
            let _ = print("frameSize = \(frameSize) textSize = \(textSize) fc \(frameCaptured) \(frameCapturedBinding) tc \(textCaptured) \(textCapturedBinding)")
            let _ = print("scaleHorizontal = \(scaleHorizontal) marginFactor = \(marginFactor) scale \(scale)")
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
                                    .background(Color.red.opacity(0.2))
                                    .padding(textSize.height*0.4)
                                    .background(Color.red.opacity(0.2))
//                                    .border(Color.green, width: borderwidth)
                                    //.animation(.linear(duration: 0.0))
//                                    .background(Color.green.opacity(0.2))
                            )
                    }
                    .fixedSize(horizontal: true, vertical: true)
                }
                .scaleEffect(scale)
            }
        }
    }
}

struct StampView_Previews: PreviewProvider {
    static var previews: some View {
        StampView(top: "Bullshit")
    }
}
