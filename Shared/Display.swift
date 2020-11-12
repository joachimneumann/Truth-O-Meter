//
//  Display.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 11/11/20.
//

import SwiftUI

struct Display: View {
    @EnvironmentObject var userSettings: UserSettings
    var body: some View {
        ZStack {
            DisplayBackground()
            Text(userSettings.title)
                .offset(y: 15)
                .foregroundColor(C.Colors.gray)
                .font(.headline)
            Needle()
                .clipped()
        }
        .aspectRatio(1.9, contentMode: .fit)
        .padding(30)
    }
}

struct Display_Previews: PreviewProvider {
    static var previews: some View {
        Display()
            .environmentObject(TruthModel())
            .environmentObject(UserSettings())
    }
}
