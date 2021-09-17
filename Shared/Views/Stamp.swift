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
    @State private var frameSize = CGSize(width: 1.0, height: 1.0)
    @State private var textSize  = CGSize(width: 1.0, height: 1.0)
    
    static let defaultColor = Color(
        red: 255.0/255.0,
        green: 83.0/255.0,
        blue: 77.0/255.0)
    static let singleLineDefaultAngle = Angle(degrees: -25)
    static let doubleLineDefaultAngle = Angle(degrees: -18)
    
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
        color: Color = Self.defaultColor,
        angle userDefinedAngle: Angle? = nil
    ) {
        self.firstLine = firstLine
        self.secondLine = secondLine
        self.color = color
        if let userDefinedAngle = userDefinedAngle {
            self.angle = userDefinedAngle
        } else {
            if secondLine != nil {
                self.angle = Self.doubleLineDefaultAngle
            } else {
                self.angle = Self.singleLineDefaultAngle
            }
        }
    }
    
    struct Lines : View {
        let firstLine: String
        let secondLine: String?
        var body: some View {
            VStack {
                Text(firstLine)
                if let secondLine = secondLine {
                    Text(secondLine)
                }
            }
        }
    }
    
    struct OneOrTwoLines: View {
        let firstLine: String
        let secondLine: String?
        let color: Color
        let stampModel: StampModel
        @Binding var textSize: CGSize
        var body: some View {
            Lines(firstLine: firstLine, secondLine: secondLine)
            .font(.system(size: stampModel.largeFontSize).bold())
            .foregroundColor(color)
            .fixedSize()
            .lineLimit(1)
            .stampCaptureSize(in: $textSize)
            .padding(stampModel.padding-stampModel.borderWidth/2)
            .overlay(
                RoundedRectangle(cornerRadius: stampModel.cornerRadius)
                    .stroke(color, lineWidth: stampModel.borderWidth))
            .padding(stampModel.borderWidth/2)
        }
    }
    
    var body: some View {
        
        let stampModel = StampModel(
            tw: Float(frameSize.width),
            th: Float(frameSize.height),
            fw: Float(textSize.width),
            fh: Float(textSize.height),
            angle: Float(angle.radians))
        
        ZStack {
            FrameCatcher(into: $frameSize)
            VStack {
                ZStack {
                    Rectangle()
                        .foregroundColor(.clear)//green.opacity(0.2))
                        .background(
                            OneOrTwoLines(
                                firstLine: firstLine,
                                secondLine: secondLine,
                                color: color,
                                stampModel: stampModel,
                                textSize: $textSize)
                        )
                        .mask(Image(uiImage: UIImage(named: "mask")!)
                                .resizable()
                                .scaledToFill()
                                .frame(width: stampModel.maskSize, height: stampModel.maskSize, alignment: SwiftUI.Alignment.center)
                        )
                }
                .fixedSize(horizontal: true, vertical: true)
            }
            .scaleEffect(stampModel.scale)
            .rotationEffect(angle)
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
