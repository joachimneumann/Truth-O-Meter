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
        //let settings = Settings()
        Needle.shared.active(true, strongNoise: false)
        return WindowGroup {
            #if targetEnvironment(macCatalyst)
            PlaygroundView()
                .frame(width: 375, height: 667)
            #else
            PlaygroundView()
            #endif
            //                .background(Color.white)
            
            
            //            MainView()
            //                .environmentObject(settings)
            //                .environmentObject(NavigationStack())
            
        }
    }
}
