//
//  AllDisksView.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 30/08/2021.
//

import SwiftUI

struct AllDisksView: View {
    @EnvironmentObject private var settings: Settings
    let radius: Double
    var isSetting: Bool
    
    @State private var pale: Bool = false
    @State private var circle: Bool = true
    @State private var disksHidden = false
    
    let color: Color
    let grayColor: Color
    let callback: (Precision) -> Void
    
    private let disks = Disks()
    
    func downPressed() {
        if isSetting {
            
        } else {
            if !pale {
                pale = true
                disksHidden = true
            }
        }
    }
    
    func upPressed(_ precision: Precision) {
        if isSetting {
            callback(precision)
        } else {
            if circle {
                DispatchQueue.main.asyncAfter(deadline: .now() + C.timing.shapeShiftAnimationTime) {
                    callback(precision)
                }
                pale = false
                circle = false
                disksHidden = true
            }
        }
    }
    
    var body: some View {
        // print("AllDisksView pale \(pale)")
        //        GeometryReader { geo in
//        let radius = min(geo.size.width, geo.size.height) / 2
        ZStack {
            ShapeShifterView(
                isGray: isSetting && settings.precision == .edge,
                down: downPressed,
                up: {
                    upPressed(.edge)
                },
                isCircle: circle,
                color: color,
                grayColor: grayColor,
                animationTime: C.timing.shapeShiftAnimationTime)
            DiskView(
                isOpaque: !pale && circle,
                borderWidth: isSetting ? 2.0 : 0.0,
                isGray: isSetting && settings.precision == disks.disks[0].precision,
                down: downPressed,
                up: {
                    upPressed(disks.disks[0].precision)
                },
                color: color,
                grayColor: grayColor)
                .padding(disks.disks[0].padding(radius: radius))
            DiskView(
                isOpaque: !pale && circle,
                borderWidth: isSetting ? 2.0 : 0.0,
                isGray: isSetting && settings.precision == disks.disks[1].precision,
                down: downPressed,
                up: {
                    upPressed(disks.disks[1].precision)
                },
                color: color,
                grayColor: grayColor)
                .padding(disks.disks[1].padding(radius: radius))
            DiskView(
                isOpaque: !pale && circle,
                borderWidth: isSetting ? 2.0 : 0.0,
                isGray: isSetting && settings.precision == disks.disks[2].precision,
                down: downPressed,
                up: {
                    upPressed(disks.disks[2].precision)
                },
                color: color,
                grayColor: grayColor)
                .padding(disks.disks[2].padding(radius: radius))
            DiskView(
                isOpaque: !pale && circle,
                borderWidth: isSetting ? 2.0 : 0.0,
                isGray: isSetting && settings.precision == disks.disks[3].precision,
                down: downPressed,
                up: {
                    upPressed(disks.disks[3].precision)
                },
                color: color,
                grayColor: grayColor)
                .padding(disks.disks[3].padding(radius: radius))
        }
    }
}

struct Disks_Previews: PreviewProvider {
    static var previews: some View {
        func f(p: Precision) {}
        return AllDisksView(
            radius: 200,
            isSetting: true,
            color: C.color.bullshitRed,
            grayColor: C.color.lightGray,
            callback: f)
    }
}
