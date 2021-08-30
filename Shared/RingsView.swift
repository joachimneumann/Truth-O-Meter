//
//  RingsView.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 26/08/2021.
//

import SwiftUI

struct RingsView: View {
    @ObservedObject var viewModel: ViewModel
    
    
    var body: some View {
        AllRings(viewModel: viewModel)
        //                if drawBorders {
        //                    Circle()
        //                        .stroke(C.color.lightGray, lineWidth: 1)
        //                        .padding(ringPadding.outer)
        //                    Circle()
        //                        .stroke(C.color.lightGray, lineWidth: 1)
        //                        .padding(ringPadding.middle)
        //                    Circle()
        //                        .stroke(C.color.lightGray, lineWidth: 1)
        //                        .padding(ringPadding.inner)
        //                    Circle()
        //                        .stroke(C.color.lightGray, lineWidth: 1)
        //                        .padding(ringPadding.bullsEye)
        //                }
        //            }
        //        }
    }
}

//.gesture(
//    DragGesture(minimumDistance: 0)
//        .onChanged { _ in
//            if !executed || executeMultipleTimes {
//                tapDownCallback()
//                if opaque {
//                    opaque = false
//                }
//            }
//        }
//
//        .onEnded { _ in
//            if !executed || executeMultipleTimes {
//                tapUpCallback()
//                opaque = true
//                circle.toggle()
//                executed = true
//            }
//        }
//)

struct RingsView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ViewModel()
        //        viewModel.setState(.settings)
        return RingsView(viewModel: viewModel)
        //            .padding()
    }
}

//extension View {
//    /// Hide or show the view based on a boolean value.
//    ///
//    /// Example for visibility:
//    ///
//    ///     Text("Label")
//    ///         .isHidden(true)
//    ///
//    /// Example for complete removal:
//    ///
//    ///     Text("Label")
//    ///         .isHidden(true, remove: true)
//    ///
//    /// - Parameters:
//    ///   - hidden: Set to `false` to show the view. Set to `true` to hide the view.
//    ///   - remove: Boolean value indicating whether or not to remove the view.
//    @ViewBuilder func isHidden(_ hidden: Bool, remove: Bool = false) -> some View {
//        if hidden {
//            if !remove {
//                self.hidden()
//            }
//        } else {
//            self
//        }
//    }
//}

func paddingForPrecision(radius: CGFloat, precision: Precision) -> CGFloat {
    // Instead of 0, 0.2, 0.4, 0.6, 0.8, 1.0
    // I make the bulls eye and the out ring a bit larger
    // This makes the edge results easier to hit.
    let tapEdge:CGFloat     = 1.0
    let tapOuter:CGFloat    = 0.8 - 0.05
    let tapMiddle:CGFloat   = 0.6 - 0.0125
    let tapInner:CGFloat    = 0.4 + 0.0125
    let tapBullsEye:CGFloat = 0.2 + 0.05
    switch precision {
    case .edge:
        return radius * (1.0 - tapEdge)
    case .outer:
        return radius * (1.0 - tapOuter)
    case .middle:
        return radius * (1.0 - tapMiddle)
    case .inner:
        return radius * (1.0 - tapInner)
    case .bullsEye:
        return radius * (1.0 - tapBullsEye)
    }
}

struct AllRings: View {
    var viewModel: ViewModel
    @State private var isShapeShifterCircle = true
    @State private var paleShapeShifter = false
    @State private var tappedPrecision = Precision.outer

    struct Ring: View {
        @State private var color: Color = C.color.bullshitRed
        @Binding var isShapeShifterCircle: Bool
        @Binding var paleShapeShifter: Bool
        @Binding var tappedPrecision: Precision
        var isSettingsRing: Bool
        var geoSize: CGSize
        var precision: Precision
        var tapCallback: (_ ring: Precision) -> Void

        var body: some View {
            let w = min(geoSize.width, geoSize.height)
            let paddingValue = paddingForPrecision(
                radius: w / 2,
                precision: precision)
            print("Ring isShapeShifterCircle=\(isShapeShifterCircle) paleShapeShifter=\(paleShapeShifter) w=\(w)")
            let isVisible = isShapeShifterCircle && !paleShapeShifter
            return ZStack {
                Circle()
                    .fill(Color.blue)//tappedPrecision == precision && isSettingsRing ? C.color.lightGray : C.color.bullshitRed)
                    .opacity(isVisible ? 1.0 : 0.0)
                    .animation(nil)
                    .padding(paddingValue)
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { _ in
                                print("Ring down")
                                if !isSettingsRing {
                                    paleShapeShifter = true
                                }
                            }

                            .onEnded { _ in
                                print("Ring up")
                                tapCallback(precision)
                                if isSettingsRing {
                                    tappedPrecision = precision
                                    print("tappedPrecision = \(precision)")
                                } else {
                                    paleShapeShifter = false
                                    isShapeShifterCircle.toggle()
                                    tappedPrecision = precision
                                    print("precision = \(precision)")
                                }
                            }
                    )
                    if isSettingsRing {
                        Circle()
                            .stroke(C.color.lightGray, lineWidth: 1)
                            .padding(paddingValue)
                    }
            }
        }
    }
    
    var body: some View {
        if viewModel.state == .listen {
            isShapeShifterCircle = true
        }
        return GeometryReader { (geo) in
            Group {
                ShapeShifterDisk(
                    circle: isShapeShifterCircle,
                    opaque: !paleShapeShifter,
                    geoSize: geo.size,
                    color: C.color.bullshitRed)
                    .padding(0)
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { _ in
                                paleShapeShifter = true
                            }

                            .onEnded { _ in
                                paleShapeShifter = false
                                isShapeShifterCircle.toggle()
                            }
                    )
                Ring(isShapeShifterCircle: $isShapeShifterCircle, paleShapeShifter: $paleShapeShifter,
                     tappedPrecision: $tappedPrecision, isSettingsRing: viewModel.isSettingsState,
                     geoSize: geo.size, precision: .outer,
                     tapCallback: viewModel.tap)
            }
        }
    }
}
