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
        func f() {}
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
            StampView(top: "12", bottom: nil, rotated: true, color: Color.blue)
//            DiskView(isOpaque: true, borderWidth: 2, isGray: false, down: f, up: f, color: C.color.bullshitRed, grayColor: C.color.lightGray)
//            MainView()
                .environmentObject(settings)
                .environmentObject(NavigationStack())
            #endif
        }
    }
}
