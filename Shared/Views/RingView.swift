//
//  RingView.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 30/08/2021.
//

import SwiftUI

struct RingView: View {
    @EnvironmentObject private var preferences: Preferences
    let width: Double
    let activeColor: Color
    let passiveColor: Color
    
    @State private var animateValue: Double = 0.0
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(passiveColor, lineWidth: width)
            Circle()
                .trim(from: 0, to: animateValue)
                .stroke(activeColor, lineWidth: width)
                .rotationEffect(Angle(degrees:-90))
                .animation(.linear(duration: preferences.listenTime), value: animateValue)
        }
        .onAppear() {
            animateValue = 1.0
        }
    }
}

struct RingView_Previews: PreviewProvider {
    static var previews: some View {
        func doNothing() {}
        return RingView(
            width: 10,
            activeColor: Color.red,
            passiveColor: Color.gray)
    }
}
