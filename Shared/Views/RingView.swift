//
//  RingView.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 30/08/2021.
//

import SwiftUI
import GameKit /// for Audio

struct RingView: View {
    @EnvironmentObject private var settings: Settings
    var width: Double
    var whenFinished: () -> Void

    @State private var value = 0.0
    
    func startSound() {
        AudioServicesPlaySystemSound(C.sounds.startRecording)
    }
    func endSound() {
        AudioServicesPlaySystemSound(C.sounds.stopRecording)
    }
    
    var body: some View {
        Group {
            Circle()
                .stroke(C.color.lightGray, lineWidth: width)
            Circle()
                .trim(from: 0, to: value)
                .stroke(C.color.bullshitRed, lineWidth: width)
                .rotationEffect(Angle(degrees:-90))
                .animation(.linear(duration: settings.listenTime))
        }
        .onAppear {
            value = 1.0
            startSound()
            let delay = DispatchTime.now() + settings.listenTime
            DispatchQueue.global().asyncAfter(deadline: delay) {
                endSound()
                /// this will not guarantee precise timing,
                /// but that might not be required here
                whenFinished()
            }
        }
    }
    
}

struct RingView_Previews: PreviewProvider {
    static var previews: some View {
        func doNothing() {}
        return RingView(width: 10, whenFinished: doNothing)
    }
}
