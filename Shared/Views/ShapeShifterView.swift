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
    var geoSize: CGSize
    
    private let borderColor = C.color.lightGray
    private let color = C.color.bullshitRed
    private let grayColor = C.color.lightGray
    
    @State private var isDown = false
    var body: some View {
        let w = min(geoSize.width, geoSize.height)
        ZStack {
            Rectangle()
                .fill(isGray ? grayColor : color)
                .cornerRadius(isCircle ? w/2 : w/14)
                .padding(isCircle ? 0 : w/4)
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
//View {
//
//    var isGray: Bool
//    var isCircle: Bool
//    var animate: Bool
//    var down: () -> Void
//    var up: () -> Void
//
//    private let color = C.color.bullshitRed
//    private let grayColor = C.color.lightGray
//
//    var body: some View {
//        let color = isGray ? grayColor : color
////        print("Shapeshifter gray=\(isGray) circle=\(isCircle)")
//        return GeometryReader { geo in
//            let w = min(geo.size.width, geo.size.height)
//            VStack {
//                Spacer(minLength: 0)
//                HStack {
//                    Spacer(minLength: 0)
//                    Rectangle()
//                        .cornerRadius(isCircle ? w/2 : w/14)
//                        .padding(isCircle ? 0 : w/4)
//                        .animation(
//                            .linear(
//                                duration:
//                                animate ? C.timing.shapeShiftAnimationTime : 0))
//                        .foregroundColor(color)
//                        .aspectRatio(contentMode: .fit)
//                        .gesture(
//                            DragGesture(minimumDistance: 0)
//                                .onChanged { _ in down() }
//                                .onEnded   { _ in up()   }
//                        )
//                    Spacer(minLength: 0)
//                }
//                Spacer(minLength: 0)
//            }
//        }
//    }
//}

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
