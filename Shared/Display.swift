//
//  Display.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 11/11/20.
//

import SwiftUI

struct Display: View {
    @State var isGrayedOut: Bool
    @EnvironmentObject var userSettings: UserSettings
    var body: some View {
        ZStack {
            DisplayBackground(isGrayedOut: isGrayedOut)
            Text(userSettings.title)
                .offset(y: 15)
                .foregroundColor(isGrayedOut ? C.Colors.lightGray : C.Colors.gray)
                .font(.headline)
            Needle(isGrayedOut: isGrayedOut)
                .clipped()
        }
        .aspectRatio(1.9, contentMode: .fit)
        .padding(30)
    }
}

struct Display_Previews: PreviewProvider {
    static var previews: some View {
        Display(isGrayedOut: false)
            .environmentObject(UserSettings())
    }
}
