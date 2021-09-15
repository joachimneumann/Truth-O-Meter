//
//  PlaygroundView.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 08/09/2021.
//

import SwiftUI


struct PlaygroundView: View {
    private var privateFrameWidth = 100.0
    @State private var frameWidth = 100.0
    @State private var frameHeight = 100.0
    @State var angle = Angle(degrees: 0.0)

    var body: some View  {
        ZStack {
            StampView("É", angle: angle)
            
                .frame(width: frameWidth, height: frameHeight)
                //.background(Color.blue.opacity(0.1))
                .border(Color.blue, width: 1)
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
