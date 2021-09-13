//
//  StampView.swift
//  StampView
//
//  Created by Joachim Neumann on 13/09/2021.
//

import SwiftUI

struct StampView: View {
    let text: String
    let largeFontSize = 300.0
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
                //            HStack {
    //                Text("This is a short string.")
    //                    .padding()
    //                    .frame(maxHeight: .infinity)
    //                    .background(Color.red)
    //
    //                Text("This is a very long string with lots and lots of text that will definitely run across")
    //                    .padding()
    //                    .frame(maxHeight: .infinity)
    //                    .background(Color.green)
    //            }
    //            .fixedSize(horizontal: false, vertical: true)
    //            .frame(maxHeight: 150)
                VStack {
                    Rectangle()
                        .foregroundColor(.green.opacity(0.2))
                        .frame(height: 310)
                        .background(
                            Text("iiiiiiiii")
                                .font(.system(size: largeFontSize))
                                .minimumScaleFactor(0.01)
                                .captureSize(in: $textSize)
                                .background(Color.pink.opacity(0.2))
                                .scaleEffect(scaleHorizontal)
                        )
                    Rectangle()
                        .foregroundColor(.yellow.opacity(0.2))
                        .frame(width: frameSize.width, height: 50)
                }
                .fixedSize(horizontal: true, vertical: true)
            }
        }
        .padding()

        
        //
        //        let scaleHorizontal = frameSize.width / textSize.width
        ////        let scaleHorizontal = textSize.width / frameSize.width
        //        ZStack {
        //            Group {
        //            CaptureText(text: text, fontSize: largeFontSize, textSize: $textSize)
        //            CaptureFrame(frameSize: $frameSize)
        //            }
        //            VStack {
        //                HorizontalStamp(
        //                    text: text,
        //                    fontSize: largeFontSize)
        //                    .background(Color.green.opacity(0.2))
        //                    .scaleEffect(scaleHorizontal)
        //                Text("frame (\(frameSize.width.s), \(frameSize.height.s))\ntext  (\(textSize.width.s), \(textSize.height.s)),\nscale \(scaleHorizontal)")
        //                    .font(.system(size: 14, design: .monospaced))
        //                    .padding()
    }
    
    struct HorizontalStamp: View {
        let text: String
        let fontSize: Double
        var body: some View {
            Text(text)
                .lineLimit(1)
                .fixedSize()
                .font(.system(size: fontSize))
        }
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
