//
//  SmartButton.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 30/08/2021.
//

import SwiftUI
import GameKit /// for Audio

struct SmartButtonView: View {
    let color: Color
    let gray: Color
    let paleColor: Color
    let listenTime: Double
    let analysisTime: Double
    @Binding var displayColorful: Bool
    let callback: (Precision) -> Void
    
    @State private var smartButtonSize: CGSize = CGSize(width: 10, height: 10)
    @State private var tappedPrecision: Precision = .bullsEye
    
    private struct FrameCatcher: View {
        @Binding var into: CGSize
        var body: some View {
            Rectangle()
                .foregroundColor(.clear)//.blue.opacity(0.2))
                .background(
                    Rectangle()
                        .foregroundColor(.clear)
                        .captureSize(in: $into)
                )
        }
    }
    
    func tapped(_ precision: Precision) {
        let startRecording:UInt32 = 1113
        let stopRecording:UInt32 = 1114
        /// source: https://github.com/TUNER88/iOSSystemSoundsLibrary
        
        DispatchQueue.main.async {
            AudioServicesPlaySystemSound(startRecording)
        }
        
        Needle.shared.active(true, strongNoise: true)
        let v: Double
        switch precision {
        case .edge:
            v = 1.0
        case .outer:
            v = 0.75
        case .middle:
            v = 0.5
        case .inner:
            v = 0.25
        case .bullsEye:
            v = 0.0
        }
        Needle.shared.setValueInSteps(v, totalTime: listenTime + analysisTime)
        displayColorful = true
        tappedPrecision = precision
        animateRingView = true
        let whenWhen: DispatchTime = DispatchTime.now() +
            DispatchTimeInterval.milliseconds(Int(1000.0 * listenTime))
        DispatchQueue.main.asyncAfter(deadline: whenWhen) {
            AudioServicesPlaySystemSound(stopRecording)
            callback(tappedPrecision)
        }
    }
    
    struct Config {
        let padding: Double
        let ringWidth: Double
        let fiveDisksRadius: Double
        init(radius: Double) {
            ringWidth = 0.05 * radius
            fiveDisksRadius = radius - 3.0 * ringWidth
            padding = 0.5 * ringWidth
        }
    }
    
    @State private var animateRingView: Bool = false
    
    var body: some View {
        let config = Config(radius: min(smartButtonSize.width, smartButtonSize.height))
        ZStack {
            FrameCatcher(into: $smartButtonSize)
            if animateRingView {
                RingView(
                    time: listenTime,
                    width: config.ringWidth,
                    activeColor: color,
                    passiveColor: gray)
            } else {
                Circle()
                    .stroke(gray, lineWidth: config.ringWidth)
            }
            FiveDisks(precision: .constant(nil),
                      radius: config.fiveDisksRadius,
                      color: color,
                      paleColor: paleColor,
                      callback: tapped)
        }
        .padding(config.padding)
    }
}

struct SmartButton_Previews: PreviewProvider {
    static var previews: some View {
        SmartButtonView(
            color: Color.red,
            gray: Color.gray,
            paleColor: Color.orange,
            listenTime: 1.0,
            analysisTime: 1.0,
            displayColorful: .constant(true)) { p in
            }
    }
}
