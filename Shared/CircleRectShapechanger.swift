//
//  CircleRectShapechanger.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 29/08/2021.
//

import SwiftUI

struct CircleRectShapechanger: View {
    private let executeMultipleTimes = false
    // Normally, you want executeMultipleTimes to be true.
    // In the Truth-O-Meter App, I want only a single animation
    // from circle to rectangle

    var tapDownCallback: () -> Void
    var tapUpCallback: () -> Void
    var color: Color
    @State private var circle = true
    @State private var opaque = true

    @State private var executed = false

    var body: some View {
        GeometryReader { (geo) in
            let w: CGFloat = min(geo.size.height, geo.size.width)
//            Rectangle()
//                .cornerRadius(circle ? w/2 : w/14)
            Rectangle()
                .cornerRadius(circle ? w/2 : w/14)
                .padding(circle ? 0 : w/4)
                .animation(.linear(duration: 0.25))
                .foregroundColor(color)
                .opacity(opaque ? 1.0: 0.3)
                .animation(.linear(duration: 0.1))
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { _ in
                            if !executed || executeMultipleTimes {
                                tapDownCallback()
                                if opaque {
                                    opaque = false
                                }
                            }
                        }

                        .onEnded { _ in
                            if !executed || executeMultipleTimes {
                                tapUpCallback()
                                opaque = true
                                circle.toggle()
                                executed = true
                            }
                        }
                )
        }
        .aspectRatio(contentMode: .fit)
    }
}

struct CircleRectShapechanger_Previews: PreviewProvider {
    static func mycall() {}
    static var previews: some View {
        CircleRectShapechanger(
            tapDownCallback: CircleRectShapechanger_Previews.mycall,
            tapUpCallback: CircleRectShapechanger_Previews.mycall,
            color: C.color.bullshitRed)
            .background(Color.blue)
            .padding(100)
    }
}

