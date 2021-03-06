//
//  CircularProgressBar.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 14/11/2020.
//

import SwiftUI

struct CircularProgressBar: View {
    let ringWidth:CGFloat
    @Binding var value:CGFloat
    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0, to: value)
                .stroke(Color.red, lineWidth:ringWidth)
                .frame(width:100)
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
        CircularProgressBar(ringWidth: 10, value: .constant(0.8))
    }
}
