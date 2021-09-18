//
//  TruthView.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 16/08/2021.
//

import SwiftUI

struct NeedleView: View {
    @ObservedObject var needle = Needle.shared

    let displayMeasures: DisplayMeasures
    let activeColor:Color
    let passiveColor:Color
    
    func angle(_ v: Double) -> Angle {
        return Angle(radians: displayMeasures.completeAngle * (-0.5 + v))
    }
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.clear)
                .background(Capsule()
                                .fill(needle.colorful ? activeColor : passiveColor)
                                .clipShape(Rectangle())
                                .frame(width: displayMeasures.thickLine, height: displayMeasures.radius2+displayMeasures.thickLine)
                                .rotationEffect(angle(needle.noisyValue), anchor: .bottom)
                                .offset(y:displayMeasures.needleYOffset)
                                .animation(.linear(duration: 0.4), value: needle.noisyValue)
                )
                .clipped()
        }
    }
    
    init(displayMeasures: DisplayMeasures, activeColor: Color, passiveColor: Color) {
        self.displayMeasures = displayMeasures
        self.activeColor = activeColor
        self.passiveColor = passiveColor
    }
}


struct NeedleView_Previews: PreviewProvider {
    static var previews: some View {
        Needle.shared.active(true, strongNoise: false)
        Needle.shared.setValue(1.0)
        return GeometryReader { geo in
            NeedleView(displayMeasures: DisplayMeasures(geo.size), activeColor: Color.red, passiveColor: Color.gray)
                .background(Color.green.opacity(0.2))
        }
    }
}
