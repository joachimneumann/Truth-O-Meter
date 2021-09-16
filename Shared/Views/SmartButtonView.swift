//
//  SmartButton.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 30/08/2021.
//

import SwiftUI

struct SmartButtonView: View {
    @Binding var isTapped: Bool
    @Binding var preferencesPrecision: Precision?
    let radius: Double
    let color: Color
    let paleColor: Color
    let callback: (Precision) -> Void

    @State var smartButtonSize: CGSize = CGSize(width: 10, height: 10)
    @State var showRingProgress = false
    @State var tappedPrecision: Precision = .bullsEye

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
        showRingProgress = true
        tappedPrecision = precision
    }
    
    func ringProgressFinished() {
        callback(tappedPrecision)
    }
    var body: some View {
        ZStack {
            let linewidth: Double = smartButtonSize.width * 0.05
            FrameCatcher(into: $smartButtonSize)
            if showRingProgress {
                RingView(width: linewidth, whenFinished: ringProgressFinished)
            } else {
                Circle()
                    .stroke(C.color.lightGray, lineWidth: linewidth)
            }
            FiveDisks(isTapped: .constant(false),
                      preferencesPrecision: .constant(nil),
                      radius: 200,
                      color: C.color.bullshitRed,
                      paleColor: C.color.paleBullshitRed,
                      callback: startRingAnimation)
            .padding(smartButtonSize.width * 0.05/2.0)
        }
    }
}

struct SmartButton_Previews: PreviewProvider {
    static var previews: some View {
        SmartButtonView(isTapped: .constant(false),
                        preferencesPrecision: .constant(.middle),
                        radius: 200,
                        color: C.color.bullshitRed,
                        paleColor: C.color.paleBullshitRed) { p in
        }
    }
}
