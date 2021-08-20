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
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        GeometryReader { (geometry) in
            let rect = geometry.frame(in: .global)
            var temp = Path()
            let _ = temp.addArc(center: C.displayCenter(rect: rect), radius: C.radius2(rect: rect), startAngle: C.startAngle, endAngle: C.proportionalAngle(proportion: viewModel.currentValue), clockwise: true)
            let a = temp.currentPoint!
            let b = C.displayCenter(rect: rect)

            
            VStack {
                AnimatedPath(from: a, to: b)
                    .stroke(viewModel.activeDisplay ? C.Colors.bullshitRed : C.Colors.lightGray,
                            style: StrokeStyle(lineWidth: C.lineWidth, lineCap: .round))
            }
            .aspectRatio(1.9, contentMode: .fit)
        }
    }
}

struct AnimatedPath: Shape {
    var from: CGPoint
    var to: CGPoint

    func path(in rect: CGRect) -> Path {
        Path { p in
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

struct Needle: Shape {
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

struct Line: Shape {
    var start, end: CGPoint

    func path(in rect: CGRect) -> Path {
        Path { p in
            p.move(to: start)
            p.addLine(to: end)
        }
    }
}

extension Line {
    var animatableData: AnimatablePair<CGPoint.AnimatableData, CGPoint.AnimatableData> {
        get { AnimatablePair(start.animatableData, end.animatableData) }
        set { (start.animatableData, end.animatableData) = (newValue.first, newValue.second) }
    }
}

struct TruthView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ViewModel()
        VStack {
            ModelDebugView(viewModel: viewModel)
            NeedleView(viewModel: viewModel)
                .animation(.easeIn, value: 2.0)
        }
    }
}
