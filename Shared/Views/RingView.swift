//
//  RingView.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 30/08/2021.
//

import SwiftUI
import GameKit // for Audio
#if os(macOS)
import AVFoundation // for sound on Mac
#endif


struct RingView: View {
    @EnvironmentObject private var settings: Settings
    var width: CGFloat
    var totalTime: Double
    var whenFinished: () -> Void

    @State private var value:CGFloat = 0.0
    
    var body: some View {
        return ZStack {
            Circle()
                .stroke(C.color.lightGray, lineWidth: width)
            Circle()
                .trim(from: 0, to: value)
                .stroke(C.color.bullshitRed, lineWidth: width)
                .rotationEffect(Angle(degrees:-90))
                .animation(.linear(duration: settings.analysisTime))
        }
        .onAppear {
            value = 1.0
            AudioServicesPlaySystemSound(C.sounds.startRecording)
            DispatchQueue.main.asyncAfter(deadline: .now() + settings.listenTime) {
                // this will not guarantee precise timing, but that might not be required here
                whenFinished()
            }
        }
    }
    
}

struct RingView_Previews: PreviewProvider {
    static var previews: some View {
        func doNothing() {}
        return RingView(width: 10, totalTime: 2, whenFinished: doNothing)
    }
}
