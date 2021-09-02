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
    case main, settings, detail
}

struct NavigationView: View {
    @State private var navigation: NavigationEnum = .main
    var body: some View {
        switch navigation {
        case .main:
            MainView(navigation: $navigation)
        case .settings:
            SettingsView(navigation: $navigation)
        case .detail:
            SettingsDetailView(navigation: $navigation, displayTitle: .constant("ss"))
        }
    }
}

struct NavigationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView()
    }
}
