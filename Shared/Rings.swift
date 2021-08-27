//
//  ConcentricCircles.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 26/08/2021.
//

import SwiftUI

struct Rings: View {
    @ObservedObject var viewModel: ViewModel

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
        var edgeColor = C.Colors.bullshitRed
        var outerColor = C.Colors.bullshitRed
        var middleColor = C.Colors.bullshitRed
        var innerColor = C.Colors.bullshitRed
        var bullsEyeColor = C.Colors.bullshitRed
        if viewModel.state == .settings {
            switch viewModel.settingsPrecision {
            case .edge:
                edgeColor = C.Colors.lightGray
            case .outer:
                outerColor = C.Colors.lightGray
            case .middle:
                middleColor = C.Colors.lightGray
            case .inner:
                innerColor = C.Colors.lightGray
            case .bullsEye:
                bullsEyeColor = C.Colors.lightGray
            }
        }
        print("ConcentricCircles()")
        return GeometryReader { (geo) in
            let ringPadding = RingPadding(min(geo.size.width, geo.size.height))
            ZStack {
                Circle()
                    .fill(edgeColor)
                    .padding(ringPadding.edge)
                    .onTapGesture {
                        viewModel.tap(TapPrecision.edge)
                    }
                Circle()
                    .fill(outerColor)
                    .padding(ringPadding.outer)
                    .onTapGesture {
                        viewModel.tap(TapPrecision.outer)
                    }
                Circle()
                    .fill(middleColor)
                    .padding(ringPadding.middle)
                    .onTapGesture {
                        viewModel.tap(TapPrecision.middle)
                    }
                Circle()
                    .fill(innerColor)
                    .padding(ringPadding.inner)
                    .onTapGesture {
                        viewModel.tap(TapPrecision.inner)
                    }
                Circle()
                    .fill(bullsEyeColor)
                    .padding(ringPadding.bullsEye)
                    .onTapGesture {
                        viewModel.tap(TapPrecision.bullsEye)
                    }
                if drawBorders {
                    Circle()
                        .stroke(C.Colors.lightGray, lineWidth: 1)
                        .padding(ringPadding.outer)
                    Circle()
                        .stroke(C.Colors.lightGray, lineWidth: 1)
                        .padding(ringPadding.middle)
                    Circle()
                        .stroke(C.Colors.lightGray, lineWidth: 1)
                        .padding(ringPadding.inner)
                    Circle()
                        .stroke(C.Colors.lightGray, lineWidth: 1)
                        .padding(ringPadding.bullsEye)
                }
            }
        }
    }
}

struct ConcentricCircles_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ViewModel()
        viewModel.setState(.settings)
        return Rings(viewModel: viewModel)
            .padding()
    }
}
