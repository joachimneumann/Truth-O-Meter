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
        Needle.shared.active(true, strongNoise: false)
        return WindowGroup {
            #if os(macOS)
            MainView()
                .environmentObject(settings)
                .environmentObject(NavigationStack())
                .frame(minWidth: C.w, minHeight: C.w)
                .frame(maxWidth: C.h, maxHeight: C.h)
                .background(Color.white)
            #else
            DisplayView(colorful: true, editTitle: false, activeColor: C.color.bullshitRed, passiveColor: C.color.lightGray)
                .environmentObject(settings)
                .environmentObject(NavigationStack())
            #endif
        }
    }
}
