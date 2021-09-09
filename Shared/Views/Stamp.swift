//
//  Stamp.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 08/09/2021.
//

import SwiftUI



struct Stamp: View {
    var stampModel: StampModel
    var body: some View {
        HorizontalStampText(stampModel: stampModel)
    }
    
    struct HorizontalStampText: View {
        var stampModel: StampModel
        @State private var scaleFactor:CGFloat = 1.0
        @State private var newFrameSize = CGSize(width: 100, height: 100)
        @State private var frameSize = CGSize(width: 100, height: 100)
        @State private var textSize = CGSize(width: 100, height: 100)
        @State private var textSizeCaptured = false
        @State private var frameSizeCaptured = false
        
        private let unscaledFontSize:CGFloat = 200
        
        func x(_ newFrameSize: CGSize) {
            if round(newFrameSize.width) != round(frameSize.width)
            {
                print("frameSize=\(frameSize)")
                print("newFrameSize=\(newFrameSize)")
                print("textSizeCaptured=\(textSizeCaptured)")
                print("frameSizeCaptured=\(frameSizeCaptured)")

                frameSizeCaptured = false
                textSizeCaptured = false
            }
        }
        
        var body: some View {
            GeometryReader { geo in
                ZStack {
                    Rectangle()
                        .foregroundColor(.clear)
                        .overlay(
                            GeometryReader { geo in
                                let _ = DispatchQueue.main.async {
                                    x(geo.size)
                                }
                                Color.clear
                            }
                        )
                    if !frameSizeCaptured {
                        Rectangle()
                            .padding()
                            .foregroundColor(.blue.opacity(0.1))
                            .stampCaptureSize(in: $frameSize)
                            .onAppear() {
                                frameSizeCaptured = true
                            }
                    }
                    if (frameSizeCaptured && !textSizeCaptured) {
                        Text(stampModel.text)
                            .font(.system(size: unscaledFontSize))
                            .fixedSize() // Prevents text truncating
                            .stampCaptureSize(in: $textSize)
                            .onAppear() {
                                let widthFactor = frameSize.width/textSize.width
                                let heightFactor = frameSize.height/textSize.height
                                scaleFactor = min(widthFactor, heightFactor)
                                print("onAppear() unscaledTextSize textScaleFactor \(scaleFactor)")
                                textSizeCaptured = true
                            }
                    }
                    if (textSizeCaptured && textSizeCaptured) {
                        Text(stampModel.text)
                            .font(.system(size: unscaledFontSize*scaleFactor))
                            .fixedSize()
                        //                    .scaleEffect(scaleFactor)
                    }
                }
            }
        }
    }
}

struct Stamp_Previews: PreviewProvider {
    static var previews: some View {
        Stamp(stampModel: StampModel())
            .frame(width: 200, height: 200, alignment: .center)
    }
}

