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
        let needle = Needle()
        let viewModel = ViewModel(needle)
        viewModel.setState(.wait)
        return WindowGroup {
            VStack {
//                ModelDebugView(viewModel: viewModel)
                ContentView(viewModel: viewModel)
                    .environmentObject(needle)
            }
        }
    }
}

struct Truth_O_MeterApp_Previews: PreviewProvider {
    static var previews: some View {
        let needle = Needle()
        ContentView(viewModel: ViewModel(needle))
            .environmentObject(needle)
    }
}
