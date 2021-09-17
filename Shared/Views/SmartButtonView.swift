//
//  SmartButton.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 30/08/2021.
//

import SwiftUI

struct SmartButtonView: View {
    @Binding var isTapped: Bool
    let color: Color
    let gray: Color
    let paleColor: Color
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
    
    func startRingAnimation(_ precision: Precision) {
        tappedPrecision = precision
    }
    
    func ringProgressFinished() {
        callback(tappedPrecision)
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

    var body: some View {
        let config = Config(radius: min(smartButtonSize.width, smartButtonSize.height))
        ZStack {
            FrameCatcher(into: $smartButtonSize)
            if isTapped {
                RingView(width: config.ringWidth, activeColor: color, passiveColor: gray, whenFinished: ringProgressFinished)
            } else {
                Circle()
                    .stroke(gray, lineWidth: config.ringWidth)
            }
            FiveDisks(isTapped: $isTapped,
                      preferencesPrecision: .constant(nil),
                      radius: config.fiveDisksRadius,
                      color: color,
                      paleColor: paleColor,
                      callback: startRingAnimation)
        }
        .padding(config.padding)
    }
}

struct SmartButton_Previews: PreviewProvider {
    static var previews: some View {
        SmartButtonView(isTapped: .constant(false),
                        color: Color.red,
                        gray: Color.gray,
                        paleColor: Color.orange) { p in
        }
    }
}
