//
//  RingView.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 30/08/2021.
//

import SwiftUI
import GameKit /// for Audio

struct RingView: View {
    @EnvironmentObject private var preferences: Preferences
    var width: Double
    var whenFinished: () -> Void

    @State private var value = 0.0
    
    let startRecording:UInt32 = 1113
    let stopRecording:UInt32 = 1114
    /// source: https://github.com/TUNER88/iOSSystemSoundsLibrary

    func startSound() {
        AudioServicesPlaySystemSound(startRecording)
    }
    func endSound() {
        AudioServicesPlaySystemSound(stopRecording)
    }
    
    var body: some View {
        Group {
            Circle()
                .stroke(C.color.lightGray, lineWidth: width)
            Circle()
                .trim(from: 0, to: value)
                .stroke(C.color.bullshitRed, lineWidth: width)
                .rotationEffect(Angle(degrees:-90))
                .animation(.linear(duration: preferences.listenTime))
        }
        .onAppear {
            value = 1.0
            startSound()
            let delay = DispatchTime.now() + preferences.listenTime
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
