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
    @ObservedObject var needleValue = Needle.shared
    let activeColor:Color
    let passiveColor:Color
    var body: some View {
        ZStack {
            GeometryReader { (geo) in
                let rect = geo.frame(in: .local)
                var temp = Path()
                let _ = temp.addArc(center: DisplayBackground.displayCenter(rect: rect), radius: DisplayBackground.radius2(rect: rect), startAngle: DisplayBackground.startAngle, endAngle: DisplayBackground.proportionalAngle(proportion: self.needleValue.value), clockwise: true)
                let a = temp.currentPoint!
                let b = DisplayBackground.displayCenter(rect: rect)
                AnimatedPath(from: a, to: b, c: b)
                    .stroke(self.needleValue.colorful ? activeColor : passiveColor,
                            style: StrokeStyle(lineWidth: DisplayBackground.thickLineFactor * C.lw1(geo), lineCap: .round))
            }
        }
        .aspectRatio(DisplayBackground.aspectRatio, contentMode: .fit)
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
        Needle.shared.active(true, strongNoise: false)
        return VStack {
            NeedleView(activeColor: C.color.bullshitRed, passiveColor: C.color.lightGray)
        }
    }
}
