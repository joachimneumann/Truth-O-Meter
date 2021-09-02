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
        let newNeedleValue: Double
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
            Needle.shared.active(true, strongNoise: false)
            settings.grayPrecision = precision
            Needle.shared.setValue(newNeedleValue)
        } else {
            if circle {
                displayColorful = true
                DispatchQueue.main.asyncAfter(deadline: .now() + C.timing.shapeShiftAnimationTime) {
                    showRing = false
                    showRingWithProgress = true
                }
                Needle.shared.setValueInSteps(newNeedleValue, totalTime: settings.listenAndAnalysisTime)
                Needle.shared.active(true, strongNoise: true)
                pale = false
                circle = false
                disksHidden = true
            }
        }
    }
    
    var body: some View {
        print("AllDisksView pale \(pale)")
        return GeometryReader { geo in
            let radius = min(geo.size.width, geo.size.height) / 2
            ZStack {
                ShapeShifterView(
                    isGray: isSetting && settings.grayPrecision == .edge,
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
