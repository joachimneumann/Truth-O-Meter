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
    let activeColor:Color
    let passiveColor:Color
    let animationTime: Double
    
    @State private var widthFactor = 0.0
    var body: some View {
        GeometryReader { (geo) in
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundColor(passiveColor)
                    .opacity(0.2)
                Rectangle()
                    .foregroundColor(activeColor)
                    .frame(width:geo.size.width*widthFactor, height: geo.size.height)
                    .animation(.linear(duration: animationTime), value: widthFactor)
            }
        }
        .onAppear {
            widthFactor = 1.0
            
            // callback()
            // The timing will be precise, but that
            // might be good enough for most use cases
            DispatchQueue.main.asyncAfter(deadline: .now() + animationTime) {
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
