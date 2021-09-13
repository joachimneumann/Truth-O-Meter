//
//  ShapeShifterView.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 30/08/2021.
//

import SwiftUI

struct ShapeShifterView: View {
    var isGray: Bool
    var down: () -> Void
    var up: () -> Void
    var isCircle: Bool
    
    let color: Color
    let grayColor: Color
    let animationTime: Double
    
    @State private var isDown = false
    var body: some View {
        GeometryReader { geo in
            let w = geo.size.width
            Rectangle()
                .fill(isGray ? grayColor : color)
                .cornerRadius(isCircle ? w/2 : w/14)
                .padding(isCircle ? 0 : w/4)
                .animation(.easeIn(duration: animationTime), value: isCircle)
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { _ in
                            if !isDown {
                                isDown = true
                                down()
                            }
                        }
                        .onEnded { _ in
                            if isDown {
                                isDown = false
                                up()
                            }
                        }
                )
        }
        .aspectRatio(1.0, contentMode: .fit)
    }
}

struct ShapeShifter_Previews: PreviewProvider {
    static var previews: some View {
        ShapeShifterView(
            isGray: false,
            down: {},
            up: {},
            isCircle: false,
            color: C.color.bullshitRed,
            grayColor: C.color.lightGray,
            animationTime: C.timing.shapeShiftAnimationTime)
    }
}
