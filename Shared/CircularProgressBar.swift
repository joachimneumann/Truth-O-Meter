//
//  CircularProgressBar.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 14/11/2020.
//

import SwiftUI

struct CircularProgressBar: View {
    let ringWidth:CGFloat
    let color: Color
    var value:CGFloat
    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0, to: 1)
                .stroke(C.Colors.lightGray, lineWidth:ringWidth)
            Circle()
                .trim(from: 0, to: value)
                .stroke(color, lineWidth:ringWidth)
                .rotationEffect(Angle(degrees:-90))
        }
    }
    
    func getPercentage(_ value:CGFloat) -> String {
        let intValue = Int(ceil(value * 100))
        return "\(intValue) %"
    }
}

struct CircularProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        CircularProgressBar(ringWidth: 10, color: Color.red, value: 0.8)
            .frame(width:100)
    }
}
