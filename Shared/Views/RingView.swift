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
    let width: Double
    let activeColor: Color
    let passiveColor: Color
    let whenFinished: () -> Void

    @State private var value = 0.0
    
    let startRecording:UInt32 = 1113
    let stopRecording:UInt32 = 1114
    /// source: https://github.com/TUNER88/iOSSystemSoundsLibrary
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(passiveColor, lineWidth: width)
            Circle()
                .trim(from: 0, to: value)
                .stroke(activeColor, lineWidth: width)
                .rotationEffect(Angle(degrees:-90))
                .animation(.linear(duration: preferences.listenTime))
        }
        .onAppear {
            value = 1.0
            AudioServicesPlaySystemSound(startRecording)
            let delay = DispatchTime.now() + preferences.listenTime
            DispatchQueue.main.asyncAfter(deadline: delay) {
                AudioServicesPlaySystemSound(stopRecording)
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
        return RingView(width: 10, activeColor: Color.red, passiveColor: Color.gray, whenFinished: doNothing)
    }
}
