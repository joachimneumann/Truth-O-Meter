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
    
    
    @State var ringSize: CGSize = CGSize(width: 10, height: 10)

    var body: some View {
        let linewidth = ringSize.width * 0.05
        ZStack {
            Group {
                if showRing {
                    Circle()
                        .stroke(C.color.lightGray, lineWidth: linewidth)
                }
                if showRingWithProgress {
                    RingView(width: linewidth, whenFinished: ringProgressFinished)
                }
                if showDisks {
                    AllDisksView(
                        isSetting: false,
                        color: C.color.bullshitRed,
                        grayColor: C.color.lightGray,
                        callback: callback)
                        .captureSize(in: $ringSize)
                        .padding(linewidth * 1.5)
                        .aspectRatio(contentMode: .fit)
                }
            }
            if showStampView {
                Stamp(settings.stampTop,
                          settings.stampBottom,
                      angle: settings.stampBottom == nil ? Angle(degrees: -25.0) : Angle(degrees: -18.0))
                    .contentShape(Rectangle())
                    .onTapGesture {
                        stampTapped()
                    }
                //.background(Color.green.opacity(0.2))
            }
        }
        .padding(linewidth/2)
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
