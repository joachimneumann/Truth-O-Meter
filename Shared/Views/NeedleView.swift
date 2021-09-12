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
                let w = DisplayBackground.thickLineFactor * C.lw1()
                let h = DisplayBackground.radius2(rect: rect)+w
                let o = DisplayBackground.displayCenter(rect: rect).y-h+w/2
                let x = needleValue.value
                let a = DisplayBackground.completeAngle*(-0.5+x)
                ZStack {
                    Capsule()
                        .fill(needleValue.colorful ? activeColor : passiveColor)
                        .frame(width: w, height: h)
                        .rotationEffect(a, anchor: .bottom)
                        .offset(y:o)
                        .offset(x:geo.size.width/2)
                }
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

struct NeedleView_Previews: PreviewProvider {
    static var previews: some View {
        Needle.shared.active(false, strongNoise: false)
        Needle.shared.setValue(1.0)
        return NeedleView(activeColor: C.color.bullshitRed, passiveColor: C.color.lightGray)
            .background(Color.green.opacity(0.2))
    }
}
