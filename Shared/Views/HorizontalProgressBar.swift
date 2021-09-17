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
    
    @State private var animate = false

    var body: some View {
        ZStack(alignment: Alignment.leading) {
            Rectangle()
                .foregroundColor(passiveColor)
                .frame(height: 2)
                .opacity(0.2)
            Rectangle()
                .foregroundColor(activeColor)
                .frame(width: animate ? .infinity : 0, height: 2)
                .animation(.easeIn(duration: animationTime), value: animate)
        }
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
                                     activeColor: Color.red,
                                     passiveColor: Color.gray,
                                     animationTime: 2)
    }
}
