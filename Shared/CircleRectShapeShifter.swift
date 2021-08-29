//
//  CircleRectShapeShifter.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 29/08/2021.
//

import SwiftUI

// use with this:

//.gesture(
//    DragGesture(minimumDistance: 0)
//        .onChanged { _ in
//            if opaque {
//                opaque = false
//            }
//        }
//
//        .onEnded { _ in
//            opaque = true
//            circle.toggle()
//        }
//)

struct CircleRectShapeShifter: View {
    var circle: Bool
    var opaque: Bool
    var geoSize: CGSize
    var color: Color

    private let opaqueTpPaleAnimationTime = 0.10
    private let shapeShiftTime = 0.25
    
    var body: some View {
        let w: CGFloat = min(geoSize.height, geoSize.width)
        VStack {
            Spacer(minLength: 0)
            HStack {
                Spacer(minLength: 0)
                Rectangle()
                    .cornerRadius(circle ? w/2 : w/14)
                    .padding(circle ? 0 : w/4)
                    .animation(.linear(duration: shapeShiftTime))
                    .foregroundColor(color)
                    .opacity(opaque ? 1.0: 0.3)
                    .animation(.linear(duration: opaqueTpPaleAnimationTime))
                    .aspectRatio(contentMode: .fit)
                Spacer(minLength: 0)
            }
            Spacer(minLength: 0)
        }
    }
}

struct CircleRectShapeShifter_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { (geo) in
            CircleRectShapeShifter(
                circle: true,
                opaque: true,
                geoSize: geo.size,
                color: C.color.bullshitRed)
                .background(Color.blue)
        }
    }
}

