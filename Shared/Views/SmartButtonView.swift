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
    
    var body: some View {
        // print("SmartButton")
        return
            ZStack {
                Group {
                    let linewidth = C.w * C.button.outerRingWidth
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
                            .aspectRatio(contentMode: .fit)
                    }
                }
                .padding(40)
                if showStampView {
                    VStack(alignment: .center) {
                        Spacer(minLength: 0)
                        HStack(alignment: .center) {
                            Spacer(minLength: 0)
                            StampView(
                                top: settings.stampTop,
                                bottom: settings.stampBottom,
                                rotated: true)
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    stampTapped()
                                }
                                .padding(20)
                            Spacer(minLength: 0)
                        }
                        .aspectRatio(1.3, contentMode: .fit)
                        Spacer(minLength: 0)
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
