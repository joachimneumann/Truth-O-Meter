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
    var width: CGFloat
    var totalTime: Double
    var whenFinished: () -> Void

    @State private var value = 0.0
    @State var timer: Timer? = nil
    
    var body: some View {
        return ZStack {
            Circle()
                .stroke(C.color.lightGray, lineWidth: width)
            Circle()
                .trim(from: 0, to: CGFloat(value))
                .stroke(C.color.bullshitRed, lineWidth: width)
                .rotationEffect(Angle(degrees:-90))
        }
        .onAppear {
            startTimer()
        }
    }
    
    func startTimer(){
        AudioServicesPlaySystemSound(C.sounds.startRecording)
        timer = Timer.scheduledTimer(withTimeInterval: C.timing.listeningTimeIncrement, repeats: true) { _ in
            self.value += C.timing.listeningTimeIncrement/totalTime
            if self.value >= 1.0 {
                AudioServicesPlaySystemSound(C.sounds.stopRecording)
                timer?.invalidate()
                timer = nil
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
