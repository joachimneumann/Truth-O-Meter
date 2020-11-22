//
//  Truth_O_MeterApp.swift
//  Shared
//
//  Created by Joachim Neumann on 11/10/20.
//

import SwiftUI

@main
struct Truth_O_MeterApp: App {

    var body: some Scene {
        let guiState = GuiState(state: .wait)
        WindowGroup {
            Display(title: "x")
                .environmentObject(guiState)
        }
    }
}
