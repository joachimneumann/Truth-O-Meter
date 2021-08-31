//
//  AllDisksView.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 30/08/2021.
//

import SwiftUI

struct AllDisksView: View {
    var isSetting: Bool
    var callback: (Precision) -> Void
    
    @State private var pale: Bool = false
    @State private var circle: Bool = true
    @State private var disksHidden = false
    @State private var selectedPrecisionInSettings: Precision = .middle
    
    private let disks = Disks()
    
    var body: some View {
        GeometryReader { geo in
            let radius = min(geo.size.width, geo.size.height) / 2
            ZStack {
                ShapeShifterView(
                    isGray: isSetting && selectedPrecisionInSettings == .edge,
                    isCircle: circle,
                    down: {
                        if !isSetting {
                            pale.toggle()
                            disksHidden = true
                        }
                    },
                    up: {
                        if circle { callback(.edge) }
                        if isSetting {
                            selectedPrecisionInSettings = .edge
                        } else {
                            pale.toggle()
                            circle.toggle()
                            disksHidden.toggle()
                        }
                    })
                    .opacity(pale ? 0.3 : 1.0)
                    .animation(.linear(duration: 3))//C.timing.paleAnimationTime))
                ForEach(disks.disks) { disk in
                    DiskView(
                        isOpaque: !pale && circle,
                        drawBorder: isSetting,
                        isGray: isSetting && selectedPrecisionInSettings == disk.precision,
                        down: {
                            if !isSetting {
                                pale = true
                                disksHidden = true
                            }
                        },
                        up: {
                            if circle { callback(disk.precision) }
                            if isSetting {
                                selectedPrecisionInSettings = disk.precision
                            } else {
                                pale = false
                                circle = false
                                disksHidden = true
                            }
                        })
                        .opacity(0.3)
                        .padding(disk.padding(radius: radius))
                }
            }
        }
    }
}

struct Disks_Previews: PreviewProvider {
    static var previews: some View {
        func f(p: Precision) {}
        return AllDisksView(isSetting: false, callback: f)
    }
}
