//
//  PlaygroundView.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 08/09/2021.
//

import SwiftUI


struct PlaygroundView: View {
    var stampViewModel: StampViewModel
    
    var body: some View {
        FrameAdjustingContainer() {
            Stamp(stampViewModel: stampViewModel)
        }
    }
}

struct FrameAdjustingContainer<Content: View>: View {
    @State private var frameWidth: CGFloat = 175
    @State private var frameHeight: CGFloat = 175
    @State var angleInDegrees = 0.0
    let content: () -> Content
    
    var body: some View  {
        ZStack {
            content()
                .frame(width: frameWidth, height: frameHeight)
                .border(Color.blue, width: 1)
                .background(Color.red.opacity(0.5))
            
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


struct PlaygroundView_Previews: PreviewProvider {
    static var previews: some View {
        let stampViewModel = StampViewModel(top: "top", bottom: "bottom", color: Color.green)
        PlaygroundView(stampViewModel: stampViewModel)
    }
}
