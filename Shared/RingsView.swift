//
//  RingsView.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 26/08/2021.
//

import SwiftUI

struct RingsView: View {
    @ObservedObject var viewModel: ViewModel
    @State private var hideInnerRings = false

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
    
    var body: some View {
        let drawBorders = viewModel.state == .settings
        var edgeColor = C.color.bullshitRed
        var outerColor = C.color.bullshitRed
        var middleColor = C.color.bullshitRed
        var innerColor = C.color.bullshitRed
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
        
        func downCallback() {
            hideInnerRings = true
            print("down callback()")
        }
        func upCallback() {
            hideInnerRings = true
            viewModel.tap(Precision.edge)
            print("up callback()")
        }

        return GeometryReader { (geo) in
            let ringPadding = RingPadding(min(geo.size.width, geo.size.height))
            ZStack {
                Group {
                    CircleRectShapechanger(
                        tapDownCallback: downCallback,
                        tapUpCallback: upCallback,
                        color: edgeColor)
                        .padding(ringPadding.edge)
                    Circle()
                        .fill(outerColor)
                        .isHidden(hideInnerRings)
                        .animation(nil)
                        .padding(ringPadding.outer)
                        .onTapGesture {
                            upCallback()
                        }
                    Circle()
                        .fill(middleColor)
                        .isHidden(hideInnerRings)
                        .animation(nil)
                        .padding(ringPadding.middle)
                        .onTapGesture {
                            upCallback()
                        }
                    Circle()
                        .fill(innerColor)
                        .isHidden(hideInnerRings)
                        .animation(nil)
                        .padding(ringPadding.inner)
                        .onTapGesture {
                            upCallback()
                        }
                    Circle()
                        .fill(bullsEyeColor)
                        .isHidden(hideInnerRings)
                        .animation(nil)
                        .padding(ringPadding.bullsEye)
                        .onTapGesture {
                            upCallback()
                        }
                }
                if drawBorders {
                    Circle()
                        .stroke(C.color.lightGray, lineWidth: 1)
                        .padding(ringPadding.outer)
                    Circle()
                        .stroke(C.color.lightGray, lineWidth: 1)
                        .padding(ringPadding.middle)
                    Circle()
                        .stroke(C.color.lightGray, lineWidth: 1)
                        .padding(ringPadding.inner)
                    Circle()
                        .stroke(C.color.lightGray, lineWidth: 1)
                        .padding(ringPadding.bullsEye)
                }
            }
        }
    }
}

struct RingsView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ViewModel()
//        viewModel.setState(.settings)
        return RingsView(viewModel: viewModel)
//            .padding()
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
