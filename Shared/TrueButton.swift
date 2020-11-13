//
//  TrueButton.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 11/11/20.
//

import SwiftUI

struct TrueButton: View {
    @EnvironmentObject var truthModel: TruthModel
    @EnvironmentObject var userSettings: UserSettings
    
    var body: some View {
        let tapGesture = DragGesture(minimumDistance: 0, coordinateSpace: .local).onEnded({
            var relativeTap: Double = Double($0.startLocation.x / userSettings.width)
            if relativeTap < 0.0 { relativeTap = 0.0 }
            if relativeTap > 1.0 { relativeTap = 1.0 }
            print("\($0.startLocation.x) in \(userSettings.width) --> \(relativeTap)")
            
            truthModel.newTruth(updateTo: 1.0)//relativeTap)
        })
        GeometryReader { geo in
            ZStack{
                Path { path in
                    let w = geo.size.width
                    print("xx \(w)")
                }
                Text("userSettings.question")
                    .font(.system(size: 24, design: .monospaced))
                    .fontWeight(.bold)
                    .aspectRatio(contentMode: .fill)
                    .foregroundColor(.white)
                // tab events are not triggered in GeometryReader
                // tab events are not triggered 0 opacity views
                Rectangle()
                    .foregroundColor(Color.orange.opacity(0.00000001))
            }
            .gesture(tapGesture)
        }
        .background(C.Colors.bullshitRed)
        .cornerRadius(15)
    }
    
    func taphandler(p: CGPoint, r: CGRect) {
        truthModel.newTruth(updateTo: Double(p.x / r.size.width))
    }
}



struct TrueButton_Previews: PreviewProvider {
    static var previews: some View {
        TrueButton()
            .environmentObject(UserSettings())
    }
}
