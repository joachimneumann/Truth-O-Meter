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
        let settings = Settings()
        return WindowGroup {
            #if os(macOS)
            NavigationView()
                .environmentObject(settings)
                .frame(minWidth: 375, minHeight: 667)
                .frame(maxWidth: 375, maxHeight: 667)
                .background(Color.white)
            #else
            NavigationView()
                .environmentObject(settings)
            #endif
        }
    }
}
