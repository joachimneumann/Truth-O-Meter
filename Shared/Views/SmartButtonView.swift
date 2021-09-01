//
//  SmartButton.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 30/08/2021.
//

import SwiftUI

struct SmartButtonView: View {
    @EnvironmentObject var settings: Settings
    @EnvironmentObject var needle: Needle
    @Binding var displayColorful: Bool
    @Binding var showAnalysisView: Bool
    @Binding var showStampView: Bool
    @State private var result = StampTexts("top", "bottom")
    @State private var showRing = true
    @State private var showRingWithProgress = false
    @State private var showDisks = true
        
    func ringProgressFinished() {
        needle.active(true, strongNoise: false)
        showRing = false
        showRingWithProgress = false
        showDisks = false
        showAnalysisView = true
    }
    
    func stampTapped() {
        displayColorful = false
        needle.active(false)
        needle.setValue(0.5)
        showRing = true
        showRingWithProgress = false
        showDisks = true
        showStampView = false
    }
    
    var body: some View {
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
                    result: $result,
                    showRing: $showRing,
                    showRingWithProgress: $showRingWithProgress,
                    isSetting: false)
                    .padding(linewidth * 1.5)
            }
            if showStampView {
                Stamp(texts: result)
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
