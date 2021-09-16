//
//  HorizontalProgressBar.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 20/08/2021.
//

import Foundation
import SwiftUI

struct HorizontalProgressBar: View {
    var animationFinished: () -> Void
    let activeColor: Color
    let passiveColor: Color
    let animationTime: Double
    
    @State var animate = false
    
    
    @State private var width = 0.0
    var body: some View {
        ZStack(alignment: Alignment.leading) {
            Rectangle()
                .foregroundColor(passiveColor)
                .opacity(0.2)
            Rectangle()
                .foregroundColor(activeColor)
                .frame(width: animate ? .infinity : 0)
                .animation(.easeIn(duration: animationTime), value: animate)
        }
        .frame(height: 2)
        .onAppear {
            animate = true
            
            /// The timing of animationFinished() will not be precise,
            /// but that might be good enough for most use cases
            let delay: DispatchTime = DispatchTime.now() + animationTime
            DispatchQueue.main.asyncAfter(deadline: delay) {
                animationFinished()
            }
        }
    }
}

struct HorizontalProgressbar_Previews: PreviewProvider {
    static var previews: some View {
        func doNothing() {}
        return HorizontalProgressBar(animationFinished: doNothing,
                                     activeColor: C.color.bullshitRed,
                                     passiveColor: C.color.lightGray,
                                     animationTime: 2)
    }
}
