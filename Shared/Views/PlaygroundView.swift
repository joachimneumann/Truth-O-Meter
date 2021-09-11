//
//  PlaygroundView.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 08/09/2021.
//

import SwiftUI


struct PlaygroundView: View {
    private var privateFrameWidth: CGFloat = 175
    @State private var frameWidth: CGFloat = 175
    @State private var frameHeight: CGFloat = 175
    @State var angle = Angle(degrees: -25.0)

    var body: some View  {
        ZStack {
            Stamp(
                top: "Éjsdf23842397",
                bottom: nil,
                color: C.color.bullshitRed,
                angle: angle)
                .background(Color.yellow.opacity(0.1))
                .frame(width: frameWidth, height: frameHeight)
                //.border(Color.blue, width: 1)
            VStack {
                Spacer()
                HStack {
                    Text("W")
                    Slider(value: $frameWidth, in: 50...300)
                }
                HStack {
                    Text("H")
                    Slider(value: $frameHeight, in: 50...600)
                }
                HStack {
                    Text("𝝰")
                    Slider(value: $angle.degrees, in: -90...90)
                }
            }
            .padding()
        }
    }
}


struct PlaygroundView_Previews: PreviewProvider {
    static var previews: some View {
        PlaygroundView()
    }
}
