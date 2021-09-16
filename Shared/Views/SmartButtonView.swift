//
//  SmartButton.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 30/08/2021.
//

import SwiftUI

struct SmartButtonView: View {
    @EnvironmentObject private var settings: Settings
    @Binding var displayColorful: Bool
    @Binding var showAnalysisView: Bool
    @Binding var showStampView: Bool
    @State private var showRing = true
    @State private var showRingWithProgress = false
    @State private var showDisks = true
    
    func ringProgressFinished() {
        Needle.shared.active(true, strongNoise: false)
        showRing = false
        showRingWithProgress = false
        showDisks = false
        showAnalysisView = true
    }
    
    func stampTapped() {
        displayColorful = false
        Needle.shared.active(false, strongNoise: false)
        Needle.shared.setValue(0.5)
        showRing = true
        showRingWithProgress = false
        showDisks = true
        showStampView = false
    }
    
    func callback(_ precision: Precision) {
        settings.precision = precision
        displayColorful = true
        showRing = false
        showDisks = true
        showRingWithProgress = true
        
        /// initially, set the needle a bit in the wrong direction
        let newNeedleValue = settings.needleValue(forPrecision: precision)
        let wrongDirection = -0.15 * (newNeedleValue-0.5)
        Needle.shared.setValue(0.5 + wrongDirection)
        Needle.shared.setValueInSteps(newNeedleValue, totalTime: settings.listenAndAnalysisTime)
        Needle.shared.active(true, strongNoise: true)
    }
    
    
    @State var smartButtonSize: CGSize = CGSize(width: 10, height: 10)

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
    
    var body: some View {
        ZStack {
            let linewidth: Double = smartButtonSize.width * 0.05
            FrameCatcher(into: $smartButtonSize)
            
            if showRing {
                Circle()
                    .stroke(C.color.lightGray, lineWidth: linewidth)
            }
            if showRingWithProgress {
                RingView(width: linewidth, whenFinished: ringProgressFinished)
            }
            if showDisks {
                AllDisksView(
                    radius: min(smartButtonSize.width, smartButtonSize.height) / 2,
                    isSetting: false,
                    color: C.color.bullshitRed,
                    grayColor: C.color.lightGray,
                    callback: callback)
                    .padding(linewidth * 1.5)
                    .aspectRatio(contentMode: .fit)
            }
            if showStampView {
                Stamp(settings.stampTop, settings.stampBottom)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        stampTapped()
                    }
                //.background(Color.green.opacity(0.2))
            }
        }
        .padding(smartButtonSize.width * 0.05/2.0)
    }
}

struct SmartButton_Previews: PreviewProvider {
    static var previews: some View {
        SmartButtonView(
            displayColorful: .constant(false),
            showAnalysisView: .constant(false),
            showStampView: .constant(true))
            .environmentObject(Settings())
    }
}
