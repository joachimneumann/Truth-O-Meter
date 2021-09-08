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
                .padding(stampViewModel.marginCGFloat)
                .padding(stampViewModel.borderWidthCGFloat/2)
                                .overlay(RoundedRectangle(cornerRadius: stampViewModel.borderWidthCGFloat*1.5)
                                            .stroke(stampViewModel.color, lineWidth: stampViewModel.borderWidthCGFloat))
                                .padding(stampViewModel.borderWidthCGFloat/2)
                                .border(Color.black, width: 3)
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
    
    struct RotatedStampText: View {
        @ObservedObject var stampViewModel: StampViewModel
        var body: some View {
            BorderedHorizontalStampText(stampViewModel: stampViewModel)
                .rotationEffect(Angle(radians: stampViewModel.rotationAngle))
                .scaleEffect(stampViewModel.rotationScaleCGFloat)
        }
    }


    struct Playground: View {
        @ObservedObject var stampViewModel: StampViewModel
        @State private var frameWidth: CGFloat = 175
        @State private var frameHeight: CGFloat = 175
        
        var body: some View {
            FrameAdjustingContainer(frameWidth: $stampViewModel.frameWidthCGFloat, frameHeight: $stampViewModel.frameHeightCGFloat, angleInDegrees: $stampViewModel.angleInDegrees) {
                RotatedStampText(stampViewModel: stampViewModel)
            }
        }
    }
    
    struct FrameAdjustingContainer<Content: View>: View {
        @Binding var frameWidth: CGFloat
        @Binding var frameHeight: CGFloat
        @Binding var angleInDegrees: Double
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
                    Slider(value: $angleInDegrees, in: -90...90)
                }
                .padding()
            }
        }
    }
}




struct Stamp_Previews: PreviewProvider {
    static var previews: some View {
        let stampViewModel = StampViewModel(top: "Éj23", bottom: "bottom", rotated: true, color: Color.blue)
        StampView(stampViewModel: stampViewModel)
    }
}
