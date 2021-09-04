//
//  Truth_O_MeterApp.swift
//  Shared
//
//  Created by Joachim Neumann on 11/10/20.
//

import SwiftUI
import NavigationStack

@main
struct Truth_O_MeterApp: App {
    var body: some Scene {
        let settings = Settings()
        return WindowGroup {
            #if os(macOS)
            MainView()
                .environmentObject(settings)
                .environmentObject(NavigationStack())
                .frame(minWidth: 375, minHeight: 667)
                .frame(maxWidth: 375, maxHeight: 667)
                .background(Color.white)
            #else
            MainView()
                .environmentObject(settings)
                .environmentObject(NavigationStack())
            #endif
        }
    }
}
