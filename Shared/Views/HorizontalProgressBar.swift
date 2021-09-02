//
//  HorizontalProgressBar.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 20/08/2021.
//

import Foundation
import SwiftUI

struct HorizontalProgressBar: View {
    @EnvironmentObject private var settings: Settings
    var animationFinished: () -> Void
    @State private var widthFactor: CGFloat = 0.0
    var body: some View {
        ZStack {
            GeometryReader { (geo) in
                Rectangle()
                    .foregroundColor(C.color.lightGray)
                    .opacity(0.2)
                Rectangle()
                    .foregroundColor(C.color.lightGray)
                    .frame(width:geo.size.width*widthFactor, height: geo.size.height)
                    .animation(.linear(duration: settings.analysisTime))
            }
        }
        .onAppear {
            widthFactor = 1.0
            DispatchQueue.main.asyncAfter(deadline: .now() + settings.analysisTime) {
                // this will not guarantee precise timing, but that might not be required here
                animationFinished()
            }
        }
    }
}

struct HorizontalProgressbar_Previews: PreviewProvider {
    static var previews: some View {
        func doNothing() {}
        return HorizontalProgressBar(animationFinished: doNothing)
    }
}
