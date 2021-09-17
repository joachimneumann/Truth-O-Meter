//
//  HorizontalProgressBar.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 20/08/2021.
//

import Foundation
import SwiftUI

struct HorizontalProgressBar: View {
    let activeColor: Color
    let passiveColor: Color
    let animationTime: Double
    let height:CGFloat = 4
    
    @State var animate: Bool = false

    var body: some View {
        ZStack(alignment: Alignment.leading) {
            Rectangle()
                .foregroundColor(passiveColor)
                .frame(height: height)
                .opacity(0.2)
            Rectangle()
                .foregroundColor(activeColor)
                .frame(width: animate ? .infinity : 0, height: height)
                .animation(.easeIn(duration: animationTime), value: animate)
                .onAppear() {
                    animate = true
                }
        }
    }
}

struct HorizontalProgressbar_Previews: PreviewProvider {
    static var previews: some View {
        func doNothing() {}
        return HorizontalProgressBar(activeColor: Color.red,
                                     passiveColor: Color.gray,
                                     animationTime: 2)
    }
}
