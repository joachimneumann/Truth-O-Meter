//
//  Display.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 11/11/20.
//

import SwiftUI

struct Display: View {
    @EnvironmentObject var guiState: GuiState
    let title: String

    var body: some View {
        ZStack {
            DisplayBackground()
            Text(title)
                .offset(y: 15)
                .foregroundColor(guiState.state == .analysing ? C.Colors.gray : C.Colors.lightGray)
                .font(.headline)
            Needle()
                .clipped()
        }
        .aspectRatio(1.9, contentMode: .fit)
        .padding(30)
        .padding(.top, 10)
    }
}

struct Display_Previews: PreviewProvider {
    static var previews: some View {
        Display(title: "active")
            .environmentObject(GuiState())
    }
}
