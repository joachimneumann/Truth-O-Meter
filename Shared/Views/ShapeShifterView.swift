//
//  ShapeShifterView.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 30/08/2021.
//

import SwiftUI

struct ShapeShifterView: View {
    @EnvironmentObject private var settings: Settings
    var isGray: Bool
    var down: () -> Void
    var up: () -> Void
    var isCircle: Bool
    var geoSize: CGSize
    
    private let borderColor = C.color.lightGray
    private let color = C.color.bullshitRed
    private let grayColor = C.color.lightGray
    
    @State private var isDown = false
    var body: some View {
        ZStack {
            Rectangle()
                .fill(isGray ? grayColor : color)
                .cornerRadius(isCircle ? C.w/2 : C.w/14)
                .padding(isCircle ? 0 : C.w/4)
                .animation(.easeIn(duration: C.timing.shapeShiftAnimationTime), value: isCircle)
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
    }
}

struct ShapeShifter_Previews: PreviewProvider {
    static var previews: some View {
        ShapeShifterView(
            isGray: false,
            down: {},
            up: {},
            isCircle: false,
            geoSize: CGSize(width: 100, height: 100))
            .aspectRatio(contentMode: .fit)
    }
}
