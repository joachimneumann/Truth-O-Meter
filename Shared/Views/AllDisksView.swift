//
//  AllDisksView.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 30/08/2021.
//

import SwiftUI

struct AllDisksView: View {
    @EnvironmentObject var needle: Needle
    @EnvironmentObject var settings: Settings
    @Binding var displayColorful: Bool
    @Binding var result: Result
    @Binding var showRing: Bool
    @Binding var showRingWithProgress: Bool
    var isSetting: Bool
    
    @State private var pale: Bool = false
    @State private var circle: Bool = true
    @State private var disksHidden = false
    @State private var grayPrecision: Precision = .middle
    
    private let disks = Disks()
    
    func downPressed() {
        if !pale {
            print("...down")
            if !isSetting {
                pale = true
                disksHidden = true
            }
        }
    }
    func upPressed(_ precision: Precision) {
        if circle {
            print("...up")

            needle.active(true, strongNoise: true)

            displayColorful = true

            result = settings.result(forPrecision: precision)

            DispatchQueue.main.asyncAfter(deadline: .now() + C.timing.shapeShiftAnimationTime) {
                showRing = false
                showRingWithProgress = true
            }

            switch precision {
            case .bullsEye:
                needle.setValueInSteps(0.00, totalTime: settings.listenAndAnalysisTime)
            case .inner:
                needle.setValueInSteps(0.25, totalTime: settings.listenAndAnalysisTime)
            case .middle:
                needle.setValueInSteps(0.50, totalTime: settings.listenAndAnalysisTime)
            case .outer:
                needle.setValueInSteps(0.75, totalTime: settings.listenAndAnalysisTime)
            case .edge:
                needle.setValueInSteps(1.00, totalTime: settings.listenAndAnalysisTime)
            }

            if isSetting {
                grayPrecision = precision
            } else {
                pale = false
                circle = false
                disksHidden = true
            }
        }
    }
    var body: some View {
        GeometryReader { geo in
            let radius = min(geo.size.width, geo.size.height) / 2
            ZStack {
                ShapeShifterView(
                    isGray: isSetting && grayPrecision == .edge,
                    isCircle: circle,
                    down: downPressed,
                    up: {
                        upPressed(.edge)
                    })
                    .opacity(pale ? 0.3 : 1.0)
                    .animation(.linear(duration: C.timing.paleAnimationTime))
                ForEach(disks.disks) { disk in
                    DiskView(
                        isOpaque: !pale && circle,
                        drawBorder: isSetting,
                        isGray: isSetting && grayPrecision == disk.precision,
                        down: downPressed,
                        up: {
                            upPressed(disk.precision)
                        })
                        .padding(disk.padding(radius: radius))
                }
            }
        }
    }
}

struct Disks_Previews: PreviewProvider {
    static var previews: some View {
        func f(p: Precision) {}
        return AllDisksView(
            displayColorful: .constant(true),
            result: .constant(Result("top", "bottom")),
            showRing: .constant(false),
            showRingWithProgress: .constant(false),
            isSetting: false)
    }
}
