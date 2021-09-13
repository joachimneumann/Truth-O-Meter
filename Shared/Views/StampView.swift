//
//  StampView.swift
//  StampView
//
//  Created by Joachim Neumann on 13/09/2021.
//

import SwiftUI

struct StampView: View {
    let text: String
    let largeFontSize = 100.0
    @State var frameSize: CGSize = CGSize(width: 100, height: 100)
    @State var textSize: CGSize = CGSize(width: 100, height: 100)
    var body: some View {
//        let scaleHorizontal = frameSize.width / textSize.width
        let scaleHorizontal = frameSize.width / textSize.width

        ZStack {
            CaptureFrame(frameSize: $frameSize)
            VStack {
                Text("frame (\(frameSize.width.s), \(frameSize.height.s))\ntext  (\(textSize.width.s), \(textSize.height.s)),\nscale \(scaleHorizontal)")
                    .font(.system(size: 14, design: .monospaced))
                VStack {
                    Rectangle()
                        .foregroundColor(.green.opacity(0.2))
                        .frame(height: 310)
                        .background(
//                            Text("iiiiiiiii")
                            Text(text)
                                .font(.system(size: largeFontSize))
                                .minimumScaleFactor(0.01)
                                .lineLimit(1)
                                .captureSize(in: $textSize)
                                .background(Color.pink.opacity(0.2))
                                .padding(textSize.width*0.05)
                                .border(Color.green, width: 3)
                                .rotationEffect(Angle(degrees: -25))
                                .scaleEffect(scaleHorizontal*0.89)
                        )
                    Rectangle()
                        .foregroundColor(.yellow.opacity(0.2))
                        .frame(width: frameSize.width, height: 50)
                }
                .fixedSize(horizontal: true, vertical: true)
            }
        }
        .padding()
    }

    struct CaptureFrame: View {
        @Binding var frameSize: CGSize
        var body: some View {
            Rectangle()
                .foregroundColor(.blue.opacity(0.2))
                .background(
                    Rectangle()
                        .foregroundColor(.clear)
                        .captureSize(in: $frameSize)
                )
        }
    }
    
    struct CaptureText: View {
        let text: String
        let fontSize: Double
        @Binding var textSize: CGSize
        var body: some View {
            Rectangle()
                .foregroundColor(.clear)
                .background(
                    Text(text)
                        .foregroundColor(.clear)
                        .lineLimit(1)
                        .fixedSize()
                        .font(.system(size: fontSize))
                        .captureSize(in: $textSize)
                )
        }
    }
    
}

struct StampView_Previews: PreviewProvider {
    static var previews: some View {
        StampView(text: "Bullshit")
    }
}
