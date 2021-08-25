//
//  TruthView.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 16/08/2021.
//

import SwiftUI

let p1 = CGPoint(x: 50, y: 50)
let p2 = CGPoint(x: 100, y: 25)
let p3 = CGPoint(x: 100, y: 100)

struct NeedleView: View {
    @EnvironmentObject var needle: Needle

    var body: some View {
        ZStack {
            GeometryReader { (geometry) in
                let rect = geometry.frame(in: .local)
                var temp = Path()
                let _ = temp.addArc(center: C.displayCenter(rect: rect), radius: C.radius2(rect: rect), startAngle: C.startAngle, endAngle: C.proportionalAngle(proportion: needle.noisyValue), clockwise: true)
                let a = temp.currentPoint!
                let b = C.displayCenter(rect: rect)
                AnimatedPath(from: a, to: b, c: b)
                    .stroke(needle.colorfull ? C.Colors.bullshitRed : C.Colors.lightGray,
                            style: StrokeStyle(lineWidth: C.lineWidth, lineCap: .round))
            }
        }
        .aspectRatio(1.9, contentMode: .fit)
    }
}

struct AnimatedPath: Shape {
    var from: CGPoint
    var to: CGPoint
    var c: CGPoint

    func path(in rect: CGRect) -> Path {
        return Path { p in
            p.move(to: from)
            p.addLine(to: to)
        }
    }

    var animatableData: AnimatablePair<CGPoint.AnimatableData, CGPoint.AnimatableData> {
        get { AnimatablePair(
                AnimatablePair(from.x, from.y),
                AnimatablePair(to.x, to.y))
        }
        set {
            (from.x, from.y) = (newValue.first.first, newValue.first.second)
            (to.x, to.y) = (newValue.second.first, newValue.second.second)
        }
    }
}

struct TruthView_Previews: PreviewProvider {
    static var previews: some View {
        let needle = Needle()
        let viewModel = ViewModel(needle)
        VStack {
            ModelDebugView(viewModel: viewModel)
            NeedleView()
                .environmentObject(needle)
        }
    }
}
