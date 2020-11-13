//
//  TrueButton.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 11/11/20.
//

import SwiftUI
import AudioToolbox// <AudioToolbox/AudioToolbox.h>
import AVFoundation

struct TrueButton: View {
    @EnvironmentObject var userSettings: UserSettings
    
    var body: some View {
        let tapGesture = DragGesture(minimumDistance: 0, coordinateSpace: .local).onEnded({
            var relativeTap: Double = Double($0.startLocation.x / userSettings.width)
            if relativeTap < 0.0 { relativeTap = 0.0 }
            if relativeTap > 1.0 { relativeTap = 1.0 }
            // print("\($0.startLocation.x) in \(userSettings.width) --> \(relativeTap)")
            TruthModel.shared.newTruthValue(updateTo: relativeTap)
        })
        GeometryReader { geo in
            ZStack{
                // This hack allows me to set userSettings.width after the
                // view has been layed out and after every resize on the Mac
                Path { path in
                    if abs(userSettings.width - geo.size.width) > 1.0 {
                        userSettings.width = geo.size.width
                    }
                }
                Text(userSettings.question)
                    .font(.system(size: 24, design: .monospaced))
                    .fontWeight(.bold)
                    .aspectRatio(contentMode: .fill)
                    .foregroundColor(.white)
                // Hack needed here because
                // - Tab events are not triggered in GeometryReader
                // - Tab events are not triggered views with opacity zero
                Rectangle()
                    .foregroundColor(Color.orange.opacity(0.00000001))
            }
            .gesture(tapGesture)
        }
        .background(C.Colors.bullshitRed)
        .cornerRadius(15)
    }
    
}



struct TrueButton_Previews: PreviewProvider {
    static var previews: some View {
        TrueButton()
            .environmentObject(UserSettings())
    }
}
