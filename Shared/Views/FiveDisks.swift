//
//  FiveDisks.swift
//  Truth-O-Meter (iOS)
//
//  Created by Joachim Neumann on 16/09/2021.
//

import SwiftUI

struct FiveDisks: View {
    let preferenceScreen: Bool
    let radius: Double
    let color: Color
    let paleColor: Color
    let callback: (Precision) -> Void
    
    @State var isTapped: Bool = false
    @State var grayDisk: Precision = .middle

    let diskData = [
        DiskData(.outer,    0.8 - 0.05),
        DiskData(.middle,   0.6 - 0.0125),
        DiskData(.inner,    0.4 + 0.0125),
        DiskData(.bullsEye, 0.2 + 0.05)]
    
    @State private var pale = false
    
    struct Config {
        let cr: Double
        let p: Double
        let c: Color
        let gray = Color(white: 0.7)
        let down: () -> Void
        let up: (Precision) -> Void
        init(isTapped: Bool,
             radius: Double,
             color: Color,
             pale: Bool,
             paleColor: Color,
             down: @escaping () -> Void,
             up: @escaping (Precision) -> Void) {
            cr = isTapped ? radius/14.0 : radius*0.5
            p  = isTapped ? radius*0.25 : 0.0
            c = pale ? paleColor : color
            self.down = down
            self.up = up
        }
    }
    
    
    private struct Edge: View {
        let config: Config
        let color: Color
        
        var body: some View {
            Rectangle()
                .fill(color)
                .cornerRadius(config.cr)
                .padding(config.p)
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { value in
                            config.down()
                        }
                        .onEnded { value in
                            config.up(.edge)
                        }
                )
        }
    }
    
    private struct Disk: View {
        let config: Config
        let color: Color
        let border: Bool
        let precision: Precision
        var body: some View {
            Circle()
                .fill(color)
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { value in
                            config.down()
                        }
                        .onEnded { value in
                            config.up(precision)
                        }
                )
            if border {
                Circle()
                    .stroke(config.gray, lineWidth: 1)
            }
        }
    }
    
    func down() {
        if !preferenceScreen && !pale {
            pale = true
        }
    }
    func up(_ tappedPrecision: Precision) {
        isTapped = true
        pale = false
        grayDisk = tappedPrecision
        callback(tappedPrecision)
    }
    
    var body: some View {
        let config = Config(
            isTapped: isTapped,
            radius: radius,
            color: color,
            pale: pale,
            paleColor: paleColor,
            down: down,
            up: up)
        
        func fc(for precision: Precision) -> Color {
            if preferenceScreen {
                if grayDisk == precision {
                    return config.gray
                } else {
                    return config.c
                }
            } else {
                return config.c
            }
        }
        
        return ZStack {
            Edge(config: config, color: fc(for: .edge))
            ForEach(diskData) { data in
                Disk(config: config, color: fc(for: data.precision), border: preferenceScreen, precision: data.precision)
                    .padding(data.padding*radius)
            }
            .isHidden(isTapped)
        }
        .animation(.easeIn(duration: 0.25), value: isTapped)
        .animation(.easeIn(duration: 0.1), value: pale)
        .frame(width: radius, height: radius)
    }
    
    struct DiskData: Identifiable {
        var id = UUID()
        let precision: Precision
        let padding: Double
        init(_ precision: Precision, _ r: Double) {
            self.precision = precision
            self.padding = (1.0 - r) * 0.5
        }
    }
}

struct FiveDisks_Previews: PreviewProvider {
    static var previews: some View {
        FiveDisks(
            preferenceScreen: true,
            radius: 200,
            color: Color.red,
            paleColor: Color.orange)
        { p in }
    }
}

extension View {
    /// Hide or show the view based on a boolean value.
    ///
    /// Example for visibility:
    ///
    ///     Text("Label")
    ///         .isHidden(true)
    ///
    /// Example for complete removal:
    ///
    ///     Text("Label")
    ///         .isHidden(true, remove: true)
    ///
    /// - Parameters:
    ///   - hidden: Set to `false` to show the view. Set to `true` to hide the view.
    ///   - remove: Boolean value indicating whether or not to remove the view.
    @ViewBuilder func isHidden(_ hidden: Bool, remove: Bool = false) -> some View {
        if hidden {
            if !remove {
                self.hidden()
            }
        } else {
            self
        }
    }
}
