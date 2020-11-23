//
//  Needle.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 11/11/20.
//

import SwiftUI

struct NeedleView: View {
    @ObservedObject var needleViewModel = NeedleViewModel()
    var body: some View {
        return VStack {
            Button("move", action: {
                needleViewModel.isMoving = !needleViewModel.isMoving
            })
            if needleViewModel.isMoving {
                TheNeedle(v: needleViewModel.position)
                    .stroke(C.Colors.bullshitRed,
                        style: StrokeStyle(lineWidth: C.lineWidth, lineCap: .round))
            } else {
                TheNeedle(v: needleViewModel.position)
                    .stroke(C.Colors.lightGray,
                        style: StrokeStyle(lineWidth: C.lineWidth, lineCap: .round))
            }
        }
        .aspectRatio(1.9, contentMode: .fit)
    }
}

struct TheNeedle: Shape {
    var v: Double
    func path(in rect: CGRect) -> Path {
        var temp = Path()
        var path = Path()
        temp.addArc(center: C.displayCenter(rect: rect), radius: C.radius2(rect: rect), startAngle: C.startAngle, endAngle: C.proportionalAngle(proportion: v), clockwise: true)
        let a = temp.currentPoint!
        path.move(to: C.displayCenter(rect: rect))
        path.addLine(to: a)
        return path
    }
}

struct Needle_Previews: PreviewProvider {
    static var previews: some View {
        NeedleView()
            .aspectRatio(1.9, contentMode: .fit)
    }
}
