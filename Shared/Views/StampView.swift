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
        Playground(text: top)
    }
    /*
     struct AutosizeText: View {
     var text: String
     var textColor: Color
     var frameWidth: CGFloat
     var frameHeight: CGFloat
     @Binding var textSize: CGSize
     @Binding var border: CGFloat
     
     var body: some View {
     let scalew = frameWidth / (textSize.width)
     let scaleh = frameHeight / (textSize.height)
     let scale = min(scalew, scaleh)
     return Text(text)
     .font(.system(size: 300))  // Bigger font size then final rendering
     .foregroundColor(textColor)
     .fixedSize() // Prevents text truncating
     .captureSize(in: $textSize)
     .background(Color.black.opacity(0.05))
     .scaleEffect(scale)
     .onChange(of: frameHeight, perform: { value in
     let verticalTextMargin = textSize.height / 16
     let scalew = frameWidth / (textSize.width+2*verticalTextMargin)
     let scaleh = frameHeight / (textSize.height+2*verticalTextMargin)
     let scale = min(scalew, scaleh)
     border = verticalTextMargin * scale
     })
     .onChange(of: frameWidth, perform: { value in
     let verticalTextMargin = textSize.height / 16
     let scalew = frameWidth / (textSize.width+2*verticalTextMargin)
     let scaleh = frameHeight / (textSize.height+2*verticalTextMargin)
     let scale = min(scalew, scaleh)
     border = verticalTextMargin * scale
     })
     }
     }
     */
    
    struct StampTextWithBorder: View {
        var text: String
        var color: Color
        var margin: CGFloat
        var borderWidth: CGFloat
        var body: some View {
            Text(text)
                .foregroundColor(color)
                .font(.system(size: 300))
                .fixedSize() // Prevents text truncating
//                .background(Color.black.opacity(0.1))
                .padding(margin)
//                .background(Color.red.opacity(0.6))
                .padding(borderWidth/2)
//                .background(Color.red.opacity(0.6))
                .overlay(RoundedRectangle(cornerRadius: borderWidth*1.5)
                            .stroke(color, lineWidth: borderWidth))
        }
    }
    
    struct SmartStampText: View {
        @State private var textSize = CGSize(width: 100, height: 100)

        var text: String
        var color: Color
        var frameWidth: CGFloat
        var frameHeight: CGFloat
        private let marginFactor: CGFloat = 0.25
        private let borderWidthFactor: CGFloat = 0.25
        
        var body: some View {
            let marginWidth: CGFloat = textSize.height * marginFactor
            let borderWidth: CGFloat = textSize.height * borderWidthFactor
            let scaleW = frameHeight/(textSize.height+marginWidth*2+borderWidth*2)
            let scaleH = frameWidth/(textSize.width+marginWidth*2+borderWidth*2)
            let scale = min(scaleW, scaleH)
            ZStack {
                // invisible Text --> textSize
                Text(text)
                    .foregroundColor(Color.clear)
                    .font(.system(size: 300))  // Bigger font size then final rendering
                    .fixedSize() // Prevents text truncating
                    .background(
                        GeometryReader { (geo) -> Color in
                            DispatchQueue.main.async {  // hack for modifying state during view rendering.
                                textSize = geo.size
                            }
                            return Color.clear
                        }
                    )
                StampTextWithBorder(
                    text: text,
                    color: color,
                    margin: marginWidth,
                    borderWidth: borderWidth)
                    .mask(MaskView()
                            .scaleEffect(1.3, anchor: .center)
                    )
                    .padding(borderWidth/2)
                    .border(Color.black, width: 3)
                    .scaleEffect(scale, anchor: .center)
            }
            //            .captureSize(in: $textSize)
        }
    }
//    struct StampText: View {
//        var text: String
//        var color: Color
//        var frameWidth: CGFloat
//        var frameHeight: CGFloat
//        @State private var textSize = CGSize(width: 200, height: 1000)
//        @State private var border: CGFloat = 15.0
//
//        var body: some View {
//            AutosizeText(text: text, textColor: color, frameWidth: frameWidth, frameHeight: frameHeight, textSize: $textSize, border: $border)
//                .frame(width: frameWidth, height: frameHeight)
//                .padding(border)
//                .border(color)
//                .background(Color.yellow.opacity(0.3))
//        }
//    }
    struct Playground: View {
        var text: String
        @State private var frameWidth: CGFloat = 175
        @State private var frameHeight: CGFloat = 175
        
        var body: some View {
            FrameAdjustingContainer(frameWidth: $frameWidth, frameHeight: $frameHeight) {
                SmartStampText(text: text, color: C.color.bullshitRed, frameWidth: frameWidth, frameHeight: frameHeight)
            }
        }
    }
}

private struct SizeKey: PreferenceKey {
    static let defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}


extension View {
    func captureSize(in binding: Binding<CGSize>) -> some View {
        overlay(GeometryReader { proxy in
            let _ = print("captureSize1: \(proxy.size)")
            Color.clear.preference(key: SizeKey.self, value: proxy.size)
        })
        .onPreferenceChange(SizeKey.self) {
            size in binding.wrappedValue = size
            print("captureSize2: \(size)")
        }
    }
}

struct FrameAdjustingContainer<Content: View>: View {
    @Binding var frameWidth: CGFloat
    @Binding var frameHeight: CGFloat
    let content: () -> Content
    
    var body: some View  {
        ZStack {
            content()
                .frame(width: frameWidth, height: frameHeight)
                .border(Color.blue, width: 1)
//                .background(Color.blue.opacity(0.2))
            
            VStack {
                Spacer()
                Slider(value: $frameWidth, in: 50...300)
                Slider(value: $frameHeight, in: 50...600)
            }
            .padding()
        }
    }
}


struct Stamp_Previews: PreviewProvider {
    static var previews: some View {
        StampView(top: "Éj23", bottom: "33", rotated: true, color: Color.blue)
    }
}
