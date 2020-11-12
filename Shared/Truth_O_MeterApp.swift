//
//  Truth_O_MeterApp.swift
//  Shared
//
//  Created by Joachim Neumann on 11/10/20.
//

import SwiftUI

@main
struct Truth_O_MeterApp: App {
    let truthModel = TruthModel()
    let userSettings = UserSettings()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(truthModel)
                .environmentObject(userSettings)
        }
    }
}
