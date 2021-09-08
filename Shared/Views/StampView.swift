//
//  Stamp.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 21/08/2021.
//

import SwiftUI


struct StampView: View {
    let stampViewModel: StampViewModel
    
    var body: some View {
        Playground(stampViewModel: stampViewModel)
    }
    
    struct BorderedHorizontalStampText: View {
        @ObservedObject var stampViewModel: StampViewModel
        var body: some View {
            HorizontalStampText(stampViewModel: stampViewModel)
//                .padding(stampViewModel.marginCGFloat)
            //                    .padding(borderWidth/2)
            //                    .overlay(RoundedRectangle(cornerRadius: borderWidth*1.5)
            //                                .stroke(stampViewModel.color, lineWidth: borderWidth))
            //                    .padding(borderWidth/2)
            //                    .border(Color.black, width: 3)
                .scaleEffect(stampViewModel.scaleCGFloat, anchor: .center)
        }
    }
    
    struct HorizontalStampText: View {
        let stampViewModel: StampViewModel
        var body: some View {
            ZStack {
                Text(stampViewModel.top)
                    .foregroundColor(stampViewModel.color)
                    .font(.system(size: 300))  // Bigger font size then final rendering
                    .fixedSize() // Prevents text truncating
                    .background(
                        GeometryReader { (geo) -> Color in
                            DispatchQueue.main.async {
                                stampViewModel.setTextSize(geo.size)
                            }
                            return Color.clear
                        }
                    )
            }
        }
    }

//    struct RotatedStampText: View {
//        var text: String
//        var color: Color
//        var frameWidth: CGFloat
//        var frameHeight: CGFloat
//
//        var body: some View {
//            let A1 = Double(frameWidth)
//            let B1 = Double(frameHeight)
//            let alpha = 15.0  * .pi / 180
//            let beta = Double(atan(B1/A1))
//            //            let B2 = sin(alpha + beta) * sqrt(A1*A1+B1*B1)
//            let term1 = sin(alpha + beta)
//            let term2 = sqrt(A1*A1+B1*B1)
//            let B2 = term1 * term2
//            let rotationScaleFactor = B1/B2
//            HorizontalStampText(text: text, color: color, frameWidth: frameWidth, frameHeight: frameHeight)
//                .rotationEffect(Angle(degrees: 15))
//        }
//    }

    struct Playground: View {
        @ObservedObject var stampViewModel: StampViewModel
        @State private var frameWidth: CGFloat = 175
        @State private var frameHeight: CGFloat = 175
        
        var body: some View {
            FrameAdjustingContainer(frameWidth: $stampViewModel.widthCGFloat, frameHeight: $stampViewModel.heightCGFloat) {
                BorderedHorizontalStampText(stampViewModel: stampViewModel)
            }
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
                .background(Color.blue.opacity(0.1))
            
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
        let stampViewModel = StampViewModel(top: "Éj23", bottom: "bottom", rotated: true, color: Color.blue)
        StampView(stampViewModel: stampViewModel)
    }
}
