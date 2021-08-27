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
        viewModel.setState(.wait)
        return WindowGroup {
            VStack {
                #if os(macOS)
                let w : CGFloat = 375
                let h : CGFloat = 667
                MainView(viewModel: viewModel)
                    .environmentObject(viewModel.needle)
                    .frame(minWidth: w, minHeight: h)
                    .frame(maxWidth: w, maxHeight: h)
                    .background(Color.white)
                #else
                MainView(viewModel: viewModel)
                    .environmentObject(viewModel.needle)
                #endif
            }
        }
    }
}

struct Truth_O_MeterApp_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ViewModel()
        MainView(viewModel: viewModel)
            .environmentObject(viewModel.needle)
    }
}
