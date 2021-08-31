//
//  SmartButton.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 30/08/2021.
//

import SwiftUI

struct SmartButtonView: View {
    @State private var showRing = true
    @State private var showRingWithProgress = false
    @State private var showDisks = true
    @State private var showStamp = false
    
    func pressed(p: Precision) {
        DispatchQueue.main.asyncAfter(deadline: .now() + C.timing.shapeShiftAnimationTime) {
            showRing = false
            showRingWithProgress = true
        }
    }
    
    func ringProgressFinished() {
        showRing = false
        showRingWithProgress = false
        showDisks = false
        showStamp = true
    }
    
    func stampTapped() {
        showRing = true
        showRingWithProgress = false
        showDisks = true
        showStamp = false
    }
    
    var body: some View {
        GeometryReader { geo in
            let linewidth = min(geo.size.width, geo.size.height) * C.button.outerRingWidth
            if showRing {
                Circle()
                    .stroke(C.color.lightGray, lineWidth: linewidth)
            }
            if showRingWithProgress {
                RingView(width: linewidth, totalTime: 2, whenFinished: ringProgressFinished)
            }
            if showDisks {
                AllDisksView(isSetting: false, callback: pressed)
                    .padding(linewidth * 1.5)
            }
            if showStamp {
                Stamp(texts: Result("top", "bottom"))
                    .onTapGesture {
                        stampTapped()
                    }
            }
        }
    }
}

struct SmartButton_Previews: PreviewProvider {
    static var previews: some View {
        SmartButtonView()
    }
}
