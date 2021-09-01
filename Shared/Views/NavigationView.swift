//
//  NavigationView.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 31/08/2021.
//

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
            SettingsDetailView(navigation: $navigation)
        }
    }
}

struct NavigationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView()
    }
}
