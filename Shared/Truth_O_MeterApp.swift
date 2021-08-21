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
        let viewModel = ViewModel()
        viewModel.setState(.show)
        return WindowGroup {
            VStack {
//                ModelDebugView(viewModel: viewModel)
                ContentView(viewModel: viewModel)
            }
        }
    }
}

struct Truth_O_MeterApp_Previews: PreviewProvider {
    static var previews: some View {
        NeedleView(viewModel: ViewModel())
    }
}
