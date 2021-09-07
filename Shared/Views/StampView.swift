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
}

struct AutosizeText: View {
    var text: String
    var textColor: Color
    var frameWidth: CGFloat
    var frameHeight: CGFloat
    @State private var textSize = CGSize(width: 200, height: 100)
    
    var body: some View {
        let stampborder = textSize.height / 4
        let scalew = frameWidth / (textSize.width+2*stampborder)
        let scaleh = frameHeight / (textSize.height+2*stampborder)
        let scale = min(scalew, scaleh)
        
        Text(text)
            .font(.system(size: 300))  // Bigger font size then final rendering
            .foregroundColor(textColor)
            .fixedSize() // Prevents text truncating
            .captureSize(in: $textSize)
            .background(Color.black.opacity(0.05))
            .border(Color.blue, width: 1)
//            .padding(stampborder)
            .border(Color.blue, width: 1)
            .padding(stampborder)
            .border(textColor, width: 1)
            .scaleEffect(scale)
            let _ = print("captureSize: \(textSize) \(frameWidth), \(frameHeight))")
    }
}

struct StampText: View {
    var text: String
    var color: Color
    var frameWidth: CGFloat
    var frameHeight: CGFloat
    @State private var textSize = CGSize(width: 200, height: 100)
    
    var body: some View {
        AutosizeText(text: text, textColor: color, frameWidth: frameWidth, frameHeight: frameHeight)
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
            Color.clear.preference(key: SizeKey.self, value: proxy.size)
        })
        .onPreferenceChange(SizeKey.self) {
            size in binding.wrappedValue = size
            print("captureSize: \(size)")
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
            
            VStack {
                Spacer()
                Slider(value: $frameWidth, in: 50...300)
                Slider(value: $frameHeight, in: 50...600)
            }
            .padding()
        }
    }
}

struct Playground: View {
    var text: String
    @State private var frameWidth: CGFloat = 175
    @State private var frameHeight: CGFloat = 175
    
    var body: some View {
        FrameAdjustingContainer(frameWidth: $frameWidth, frameHeight: $frameHeight) {
            StampText(text: text, color: C.color.bullshitRed, frameWidth: frameWidth, frameHeight: frameHeight)
        }
    }
}


struct Stamp_Previews: PreviewProvider {
    static var previews: some View {
        StampView(top: "1Éj", bottom: "33", rotated: false, color: Color.blue)
    }
}
