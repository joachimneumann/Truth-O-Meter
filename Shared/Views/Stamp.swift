//
//  Stamp.swift
//  Draws a stamp
//
//  Created by Joachim Neumann on 13/09/2021.
//

import SwiftUI
// uses captureSize

struct Stamp: View {
    let firstLine: String
    let secondLine: String?
    let color: Color
    let angle: Angle
    
    @State var frameSize = CGSize(width: 1.0, height: 1.0)
    @State var textSize  = CGSize(width: 1.0, height: 1.0)
    
    let largeFontSize = 300.0
    
    private struct FrameCatcher: View {
        @Binding var into: CGSize
        var body: some View {
            Rectangle()
                .foregroundColor(.clear)//.blue.opacity(0.2))
                .background(
                    Rectangle()
                        .foregroundColor(.clear)
                        .stampCaptureSize(in: $into)
                )
        }
    }

    init(
        _ firstLine: String,
        _ secondLine: String? = nil,
        color: Color = Color(red: 255.0/255.0, green: 83.0/255.0, blue: 77.0/255.0),
        angle: Angle = Angle(degrees: -25)
    ) {
        self.firstLine = firstLine
        self.secondLine = secondLine
        self.color = color
        self.angle = angle
    }
    
    var body: some View {
        
        let stampModel = StampModel(frameSize: frameSize, textSize: textSize, angle: angle.radians)
        
        ZStack {
            FrameCatcher(into: $frameSize)
            //let _ = print("frameSize = \(frameSize) textSize = \(textSize)")
            //let _ = print("scale \(calc.scale)")
            VStack {
                //let _ = print("StampView VStack")
                ZStack {
                    Rectangle()
                        .foregroundColor(.clear)//green.opacity(0.2))
                        .background(
                            VStack {
                                Text(firstLine)
                                if let secondLine = secondLine {
                                    Text(secondLine)
                                }
                            }
                                .font(.system(size: largeFontSize).bold())
                                .foregroundColor(color)
                                .fixedSize()
                                .lineLimit(1)
                                //.background(Color.red.opacity(0.2))
                                .stampCaptureSize(in: $textSize)
                                .padding(stampModel.padding-stampModel.borderWidth/2)
                                .overlay(
                                    RoundedRectangle(cornerRadius: stampModel.cornerRadius)
                                        .stroke(color, lineWidth: stampModel.borderWidth))
                                .padding(stampModel.borderWidth/2)
                        )
                        .mask(Image(uiImage: UIImage(named: "mask")!)
                                .resizable()
                                .scaledToFill()
                                .frame(width: stampModel.maskSize.width, height: stampModel.maskSize.height, alignment: SwiftUI.Alignment.center)
                        )
                }
                .fixedSize(horizontal: true, vertical: true)
            }
            .scaleEffect(stampModel.scale)
            .rotationEffect(angle) // before or after scaling???
        }
    }
}

struct Stamp_Previews: PreviewProvider {
    static var previews: some View {
        Stamp("Stamp Text")
            .frame(width: 330, height: 400, alignment: .center)
    }
}

//  from https://newbedev.com/swiftui-rotationeffect-framing-and-offsetting

private struct StampSizeKey: PreferenceKey {
    static let defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

private extension View {
    func stampCaptureSize(in binding: Binding<CGSize>) -> some View {
        return overlay(GeometryReader { proxy in
            Color.clear.preference(key: StampSizeKey.self, value: proxy.size)
        })
            .onPreferenceChange(StampSizeKey.self) { size in
                DispatchQueue.main.async {
                    binding.wrappedValue = size
                }
            }
    }
}
