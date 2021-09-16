//
//  FiveDisks.swift
//  Truth-O-Meter (iOS)
//
//  Created by Joachim Neumann on 16/09/2021.
//

import SwiftUI

struct FiveDisks: View {
    @Binding var isTapped: Bool
    @Binding var settingsPrecision: Precision?
    let radius: Double
    let color: Color
    let paleColor: Color
    let callback: (Precision) -> Void

    let diskData = [
        DiskData(.outer,    0.8 - 0.05),
        DiskData(.middle,   0.6 - 0.0125),
        DiskData(.inner,    0.4 + 0.0125),
        DiskData(.bullsEye, 0.2 + 0.05)]
    
    @State private var pale = false
    
    struct Config {
        let cr: Double
        let p: Double
        let fc: Color
        let settingsPrecision: Precision?
        let down: () -> Void
        let up: (Precision) -> Void
        init(isTapped: Bool,
             radius: Double,
             color: Color,
             pale: Bool,
             paleColor: Color,
             settingsPrecision: Precision?,
             down: @escaping () -> Void,
             up: @escaping (Precision) -> Void) {
            cr = isTapped ? radius/14.0 : radius*0.5
            p  = isTapped ? radius*0.25 : 0.0
            fc = pale ? paleColor : color
            self.settingsPrecision = settingsPrecision
            self.down = down
            self.up = up
        }
    }
    
    private struct Edge: View {
        let config: Config
        let gray = Color(white: 0.7)
        var body: some View {
            Rectangle()
                .fill(config.settingsPrecision == .edge ? gray : config.fc)
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
        let precision: Precision
        let gray = Color(white: 0.7)
        var body: some View {
            Circle()
                .fill(config.settingsPrecision == precision ? gray : config.fc)
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { value in
                            config.down()
                        }
                        .onEnded { value in
                            config.up(precision)
                        }
                )
            if config.settingsPrecision != nil {
                Circle()
                    .stroke(gray, lineWidth: 1)
            }
        }
    }
    
    func down() {
        if settingsPrecision == nil && !pale {
            pale = true
        }
    }
    func up(_ precision: Precision) {
        if settingsPrecision != nil {
            settingsPrecision = precision
        } else {
            isTapped = true
            pale = false
        }
        callback(precision)
    }
    
    var body: some View {
        ZStack {
            let config = Config(
                isTapped: isTapped,
                radius: radius,
                color: color,
                pale: pale,
                paleColor: paleColor,
                settingsPrecision: settingsPrecision,
                down: down,
                up: up)
            Edge(config: config)
            ForEach(diskData) { data in
                ZStack { /// disk and border
                    Disk(config: config, precision: data.precision)
//                    Circle()
//                        .fill(grayPrecision == data.precision ? Color(white: 0.7) : c)
//                        .gesture(
//                            DragGesture(minimumDistance: 0)
//                                .onChanged { value in
//                                    if !settingsMode && !pale {
//                                        pale = true
//                                    }
//                                }
//                                .onEnded { value in
//                                    if settingsMode {
//                                        grayPrecision = .edge
//                                    } else {
//                                        isTapped = true
//                                        pale = false
//                                    }
//                                    callback(data.precision)
//                                }
//                        )
//                    if settingsMode {
//                        Circle()
//                            .stroke(Color(white: 0.7), lineWidth: 1)
//                    }
                }
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
            //print("padding \(padding)")
        }
    }
}

struct FiveDisks_Previews: PreviewProvider {
    static var previews: some View {
        func ff(_ precision: Precision) {
            print(precision)
        }
        return VStack {
            Button("back") { }
            FiveDisks(
                isTapped: .constant(false),
                settingsPrecision: .constant(nil),
                radius: 200,
                color: C.color.bullshitRed,//.opacity(0.2),
                paleColor: C.color.paleBullshitRed,
                callback: ff)
        }
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
