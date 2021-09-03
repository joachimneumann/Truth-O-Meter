//
//  NavigationView.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 31/08/2021.
//

// "normal" iOS navigation does not work in MacOS
// Therefore, I write my own very simple navigation
//
//import SwiftUI
//import NavigationStack
//
//struct NavigationView: View {
//    @EnvironmentObject var settings: Settings
//    var body: some View {
//        switch settings.navigation {
//        case .main:
//            NavigationStackView {
//                MainView()
//            }
//        case .settings:
//            NavigationStackView {
//                SettingsView()
//            }
//        case .detail:
//            NavigationStackView {
//                SettingsDetailView(displayTitle: .constant("ss"))
//            }
//        case .instructions:
//            NavigationStackView {
//                InstructionView()
//            }
//        }
//    }
//}
//
//struct NavigationView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView()
//            .environmentObject(Settings())
//    }
//}
