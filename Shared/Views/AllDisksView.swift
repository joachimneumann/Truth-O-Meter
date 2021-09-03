//
//  AllDisksView.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 30/08/2021.
//

import SwiftUI

struct AllDisksView: View {
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
        let newNeedleValue = settings.needleValue(forPrecision: precision)
        settings.precision = precision
        if isSetting {
            Needle.shared.active(true, strongNoise: false)
            Needle.shared.setValue(newNeedleValue)
        } else {
            if circle {
                displayColorful = true
                DispatchQueue.main.asyncAfter(deadline: .now() + C.timing.shapeShiftAnimationTime) {
                    showRing = false
                    showRingWithProgress = true
                }
                pale = false
                circle = false
                disksHidden = true
                // initially, set the needle a bit in the wrong direction
                let wrongDirection = -0.15 * (newNeedleValue-0.5)
                Needle.shared.setValue(0.5 + wrongDirection)
                Needle.shared.setValueInSteps(newNeedleValue, totalTime: settings.listenAndAnalysisTime)
                Needle.shared.active(true, strongNoise: true)
            } else {
                Needle.shared.active(false)
            }
        }
    }
    
    var body: some View {
        // print("AllDisksView pale \(pale)")
        return GeometryReader { geo in
            let radius = min(geo.size.width, geo.size.height) / 2
            ZStack {
                ShapeShifterView(
                    isGray: isSetting && settings.precision == .edge,
                    isCircle: circle,
                    animate: !isSetting,
                    down: downPressed,
                    up: {
                        upPressed(.edge)
                    })
                    .opacity(pale&&circle ? 0.3 : 1.0)
                    .animation(.linear(duration: isSetting ? 0 : C.timing.paleAnimationTime))
                ForEach(disks.disks) { disk in
                    DiskView(
                        isOpaque: !pale && circle,
                        drawBorder: isSetting,
                        isGray: isSetting && settings.precision == disk.precision,
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
