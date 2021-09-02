//
//  SmartButton.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 30/08/2021.
//

import SwiftUI

struct SmartButtonView: View {
    @EnvironmentObject var settings: Settings
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
        Needle.shared.active(false)
        Needle.shared.setValue(0.5)
        showRing = true
        showRingWithProgress = false
        showDisks = true
        showStampView = false
    }
    
    var body: some View {
        print("SmartButton")
        return
            GeometryReader { geo in
            let linewidth = min(geo.size.width, geo.size.height) * C.button.outerRingWidth
            if showRing {
                Circle()
                    .stroke(C.color.lightGray, lineWidth: linewidth)
            }
            if showRingWithProgress {
                RingView(width: linewidth, totalTime: settings.listenTime, whenFinished: ringProgressFinished)
            }
            if showDisks {
                AllDisksView(
                    displayColorful: $displayColorful,
                    showRing: $showRing,
                    showRingWithProgress: $showRingWithProgress,
                    isSetting: false)
                    .padding(linewidth * 1.5)
            }
            if showStampView {
                Stamp(top: settings.stampTop, bottom: settings.stampBottom, rotated: true)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        stampTapped()
                    }
            }
        }
    }
}

struct SmartButton_Previews: PreviewProvider {
    static var previews: some View {
        SmartButtonView(displayColorful: .constant(true), showAnalysisView: .constant(true), showStampView: .constant(true))
    }
}
