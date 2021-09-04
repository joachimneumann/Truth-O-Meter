//
//  AllDisksView.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 30/08/2021.
//

import SwiftUI

struct AllDisksView: View {
    @EnvironmentObject private var settings: Settings
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
                Needle.shared.active(false, strongNoise: false)
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
                    down: downPressed,
                    up: {
                        upPressed(.edge)
                    },
                    isCircle: circle,
                    geoSize: geo.size)
                DiskView(
                    isOpaque: !pale && circle,
                    drawBorder: isSetting,
                    isGray: isSetting && settings.precision == disks.disks[0].precision,
                    down: downPressed,
                    up: {
                        upPressed(disks.disks[0].precision)
                    })
                    .padding(disks.disks[0].padding(radius: radius))
                DiskView(
                    isOpaque: !pale && circle,
                    drawBorder: isSetting,
                    isGray: isSetting && settings.precision == disks.disks[1].precision,
                    down: downPressed,
                    up: {
                        upPressed(disks.disks[1].precision)
                    })
                    .padding(disks.disks[1].padding(radius: radius))
                DiskView(
                    isOpaque: !pale && circle,
                    drawBorder: isSetting,
                    isGray: isSetting && settings.precision == disks.disks[2].precision,
                    down: downPressed,
                    up: {
                        upPressed(disks.disks[2].precision)
                    })
                    .padding(disks.disks[2].padding(radius: radius))
                DiskView(
                    isOpaque: !pale && circle,
                    drawBorder: isSetting,
                    isGray: isSetting && settings.precision == disks.disks[3].precision,
                    down: downPressed,
                    up: {
                        upPressed(disks.disks[3].precision)
                    })
                    .padding(disks.disks[3].padding(radius: radius))
                
//                TODO: make ForEach work
//                Current problem: during the back animation,
//                they appear at the screen center
//
//                ForEach(disks.disks) { disk in
//                    DiskView(
//                        isOpaque: !pale && circle,
//                        drawBorder: isSetting,
//                        isGray: isSetting && settings.precision == disk.precision,
//                        down: downPressed,
//                        up: {
//                            upPressed(disk.precision)
//                        })
//                        .padding(disk.padding(radius: radius))
//                }
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
