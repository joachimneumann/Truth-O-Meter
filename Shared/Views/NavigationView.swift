//
//  NavigationView.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 31/08/2021.
//

// "normal" iOS navigation does not work in MacOS
// Therefore, I write my own very simple navigation

import SwiftUI

enum NavigationEnum {
    case main, settings, detail, instructions
}

struct NavigationView: View {
    @EnvironmentObject var settings: Settings
    var body: some View {
        switch settings.navigation {
        case .main:
            MainView(navigation: $settings.navigation)
        case .settings:
            SettingsView(navigation: $settings.navigation)
        case .detail:
            SettingsDetailView(navigation: $settings.navigation, displayTitle: .constant("ss"))
        case .instructions:
            InstructionView(navigation: $settings.navigation)
        }
    }
}

struct NavigationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView()
            .environmentObject(Settings())
    }
}
