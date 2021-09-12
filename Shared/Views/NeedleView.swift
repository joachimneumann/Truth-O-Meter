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
    let  measures: Measures
    @ObservedObject var needle = Needle.shared
    let activeColor:Color
    let passiveColor:Color
    var body: some View {
        let w = measures.thickLineFactor * C.lw1()
        let h = measures.radius2+w
        let yo:CGFloat = measures.displayCenter.y-h+2*w/3
        let xo:CGFloat = 0.0
        let x = needle.noisyValue
        let a = measures.completeAngle*(-0.5+x)
        ZStack {
            Rectangle()
                .foregroundColor(.clear)
                .background(Capsule()
                                .fill(needle.colorful ? activeColor : passiveColor)
                                .clipShape(Rectangle())
                                .frame(width: w, height: h)
                                .rotationEffect(a, anchor: .bottom)
                                .offset(y:yo)
                                .offset(x:xo)
                                .animation(.linear(duration: 0.4), value: a)
                )
        }
        .clipped()
    }
    
    init(_ forSize: CGSize, activeColor: Color, passiveColor: Color) {
        measures = Measures(forSize)
        self.activeColor = activeColor
        self.passiveColor = passiveColor
    }
}


struct NeedleView_Previews: PreviewProvider {
    static var previews: some View {
        Needle.shared.active(true, strongNoise: false)
        Needle.shared.setValue(1.0)
        return GeometryReader { geo in
            return NeedleView(geo.size, activeColor: C.color.bullshitRed, passiveColor: C.color.lightGray)
                .background(Color.green.opacity(0.2))
        }
    }
}
