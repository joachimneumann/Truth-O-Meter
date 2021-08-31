//
//  ShapeShifterView.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 30/08/2021.
//

import SwiftUI

struct ShapeShifterView: View {
    var isGray: Bool
    var isCircle: Bool
    var down: () -> Void
    var up: () -> Void

    private let color = C.color.bullshitRed
    private let grayColor = C.color.lightGray
    private let paleAnimationTime = 0.10
    private let shapeShiftAnimationTime = 0.25

    var body: some View {

        let color = isGray ? grayColor : color

        GeometryReader { geo in
            let w = min(geo.size.width, geo.size.height)
            VStack {
                Spacer(minLength: 0)
                Rectangle()
                    .cornerRadius(isCircle ? w/2 : w/14)
                    .padding(isCircle ? 0 : w/4)
                    .animation(.linear(duration: shapeShiftAnimationTime))
                    .foregroundColor(color)
                    .animation(.linear(duration: paleAnimationTime))
                    .aspectRatio(contentMode: .fit)
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { _ in
                                down()
                            }
                            .onEnded { _ in
                                up()
                            }
                    )
                Spacer(minLength: 0)
            }
        }
    }
}

struct ShapeShifter_Previews: PreviewProvider {
    static var previews: some View {
        @State var pale: Bool = false
        @State var circle: Bool = true
        @State var gray: Bool = false
        func f() {}
        return ShapeShifterView(
            isGray: false,
            isCircle: false,
            down: f,
            up: f)
    }
}
