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
        print("ConcentricCircles()")
        return GeometryReader { (geo) in
            let ringPadding = RingPadding(min(geo.size.width, geo.size.height))
            ZStack {
                Circle()
                    .fill(C.Colors.paleBullshitRed)
                Circle()
                    .fill(C.Colors.bullshitRed)
                    .padding(ringPadding.edge)
                    .onTapGesture {
                        viewModel.tap(TapPrecision.edge)
                    }
                Circle()
                    .fill(C.Colors.bullshitRed)
                    .padding(ringPadding.outer)
                    .onTapGesture {
                        viewModel.tap(TapPrecision.outer)
                    }
                Circle()
                    .fill(C.Colors.bullshitRed)
                    .padding(ringPadding.middle)
                    .onTapGesture {
                        viewModel.tap(TapPrecision.middle)
                    }
                Circle()
                    .fill(C.Colors.bullshitRed)
                    .padding(ringPadding.inner)
                    .onTapGesture {
                        viewModel.tap(TapPrecision.inner)
                    }
                Circle()
                    .fill(C.Colors.bullshitRed)
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
        Rings(viewModel: ViewModel())
            .padding()
    }
}
