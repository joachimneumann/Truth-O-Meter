//
//  HorizontalProgressBar.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 20/08/2021.
//

import SwiftUI

struct HorizontalProgressBar: View {
    let activeColor: Color
    let passiveColor: Color
    let animationTime: Double

    private let barHeight: CGFloat = 4

    @State private var isAnimating = false

    var body: some View {
        ZStack(alignment: .leading) {
            backgroundBar
            foregroundBar
        }
    }

    private var backgroundBar: some View {
        Rectangle()
            .foregroundColor(passiveColor)
            .frame(height: barHeight)
            .opacity(0.2)
    }

    private var foregroundBar: some View {
        Rectangle()
            .foregroundColor(activeColor)
            .frame(height: barHeight)
            .scaleEffect(x: isAnimating ? 1 : 0, y: 1, anchor: .leading)
            .animation(.easeIn(duration: animationTime), value: isAnimating)
            .onAppear {
                isAnimating = true
            }
    }
}

struct HorizontalProgressbar_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalProgressBar(activeColor: .red,
                              passiveColor: .gray,
                              animationTime: 2)
    }
}
