//
//  ShapeShifter.swift
//  Truth-O-Meter (iOS)
//
//  Created by Joachim Neumann on 16/09/2021.
//

import SwiftUI

struct ShapeShifter: View {
    let radius: Double
    let color: Color
    var isCircle: Bool
    var body: some View {
        let cr: Double
        let p: Double
        if isCircle {
            cr = radius/2
            p = 0.0
        } else {
            cr = radius/14
            p = radius*0.25
        }
        return Rectangle()
            .fill(color)
            .cornerRadius(cr)
            .padding(p)
            .frame(width: radius, height: radius)
            .animation(.easeIn(duration: 0.35), value: isCircle)
    }
}

struct ShapeShifter_Previews: PreviewProvider {
    static var previews: some View {
        ShapeShifter(
            radius: 200,
            color: Color.green,
            isCircle: false)
    }
}
