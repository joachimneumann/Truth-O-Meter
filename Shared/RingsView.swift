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

struct AllRings: View {
    var viewModel: ViewModel
    @State private var circle = true
    @State private var opaque = true

    private struct RingPadding {
        let edge:         CGFloat
        let outer:        CGFloat
        let middle:       CGFloat
        let inner:        CGFloat
        let bullsEye:     CGFloat
        init(_ diameter: CGFloat) {
            // Instead of 0, 0.2, 0.4, 0.6, 0.8, 1.0
            // I make the bulls eye and the out ring a bit larger
            // This makes the edge results easier to hit.
            let tapEdge:CGFloat     = 1.0
            let tapOuter:CGFloat    = 0.8 - 0.05
            let tapMiddle:CGFloat   = 0.6 - 0.0125
            let tapInner:CGFloat    = 0.4 + 0.0125
            let tapBullsEye:CGFloat = 0.2 + 0.05
            let radius = diameter / 2
            
            edge     = radius * (1.0 - tapEdge)
            outer    = radius * (1.0 - tapOuter)
            middle   = radius * (1.0 - tapMiddle)
            inner    = radius * (1.0 - tapInner)
            bullsEye = radius * (1.0 - tapBullsEye)
        }
    }
    
    struct Ring: View {
        @Binding var circle: Bool
        @Binding var opaque: Bool
        var color: Color
        var drawBorders: Bool
        var paddingValue: CGFloat
        var precison: Precision

        var body: some View {
            Circle()
                .fill(color)
                .opacity(circle && opaque ? 1.0 : 0.0)
                .animation(nil)
                .padding(paddingValue)
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { _ in
                            if !drawBorders {
                                print("Circle onChanged circle = \(circle)")
                                if opaque {
                                    opaque = false
                                }
                            }
                        }
                        
                        .onEnded { _ in
                            if !drawBorders {
                                opaque = true
                                circle.toggle()
                                print("Circle onEnded circle = \(circle)")
                            }
                        }
                )
                if drawBorders {
                    Circle()
                        .stroke(C.color.lightGray, lineWidth: 1)
                        .padding(paddingValue)
                }
        }
    }
    
    var body: some View {
        let drawBorders = viewModel.state == .settings
        var edgeColor     = C.color.bullshitRed
        var outerColor    = C.color.bullshitRed
        var middleColor   = C.color.bullshitRed
        var innerColor    = C.color.bullshitRed
        var bullsEyeColor = C.color.bullshitRed
        if viewModel.state == .settings {
            switch viewModel.settingsPrecision {
            case .edge:
                edgeColor = C.color.lightGray
            case .outer:
                outerColor = C.color.lightGray
            case .middle:
                middleColor = C.color.lightGray
            case .inner:
                innerColor = C.color.lightGray
            case .bullsEye:
                bullsEyeColor = C.color.lightGray
            }
        }
        return GeometryReader { (geo) in
            let ringPadding = RingPadding(min(geo.size.width, geo.size.height))
            Group {
                CircleRectShapeShifter(
                    circle: circle,
                    opaque: opaque,
                    geoSize: geo.size,
                    color: edgeColor)
                    .padding(ringPadding.edge)
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { _ in
                                if opaque {
                                    opaque = false
                                }
                            }
                            
                            .onEnded { _ in
                                opaque = true
                                circle.toggle()
                            }
                    )
                Ring(circle: $circle, opaque: $opaque, color: outerColor,
                     drawBorders: drawBorders, paddingValue: ringPadding.outer, precison: .outer)
                Ring(circle: $circle, opaque: $opaque, color: middleColor,
                     drawBorders: drawBorders, paddingValue: ringPadding.middle, precison: .middle)
                Ring(circle: $circle, opaque: $opaque, color: innerColor,
                     drawBorders: drawBorders, paddingValue: ringPadding.inner, precison: .inner)
                Ring(circle: $circle, opaque: $opaque, color: bullsEyeColor,
                     drawBorders: drawBorders, paddingValue: ringPadding.bullsEye, precison: .bullsEye)
            }
        }
    }
}
