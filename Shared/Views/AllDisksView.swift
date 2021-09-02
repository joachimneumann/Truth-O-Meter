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
    @Binding var showRing: Bool
    @Binding var showRingWithProgress: Bool
    var isSetting: Bool
    
    @State private var pale: Bool = false
    @State private var circle: Bool = true
    @State private var disksHidden = false
    
    private let disks = Disks()
    
    func downPressed() {
        if !pale {
            if !isSetting {
                pale = true
                disksHidden = true
            }
        }
    }
    func upPressed(_ precision: Precision) {
        if circle {

            displayColorful = true

            settings.grayPrecision = precision

            DispatchQueue.main.asyncAfter(deadline: .now() + C.timing.shapeShiftAnimationTime) {
                showRing = false
                showRingWithProgress = true
            }

            var newNeedleValue = 0.5
            switch precision {
            case .bullsEye:
                newNeedleValue = 0.00
            case .inner:
                newNeedleValue = 0.25
            case .middle:
                newNeedleValue = 0.50
            case .outer:
                newNeedleValue = 0.75
            case .edge:
                newNeedleValue = 1.00
            }

            if isSetting {
                needle.setValue(newNeedleValue)
                needle.active(true, strongNoise: false)
                settings.grayPrecision = precision
            } else {
                needle.setValueInSteps(newNeedleValue, totalTime: settings.listenAndAnalysisTime)
                needle.active(true, strongNoise: true)
                pale = false
                circle = false
                disksHidden = true
            }

        }
    }
    var body: some View {
        return GeometryReader { geo in
            let radius = min(geo.size.width, geo.size.height) / 2
            ZStack {
                ShapeShifterView(
                    isGray: isSetting && settings.grayPrecision == .edge,
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
                        isGray: isSetting && settings.grayPrecision == disk.precision,
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
            showRing: .constant(false),
            showRingWithProgress: .constant(false),
            isSetting: false)
    }
}
