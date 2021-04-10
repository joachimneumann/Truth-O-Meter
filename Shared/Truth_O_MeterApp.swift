//
//  Truth_O_MeterApp.swift
//  Shared
//
//  Created by Joachim Neumann on 11/10/20.
//

import SwiftUI

@main
struct Truth_O_MeterApp: App {

    let viewModel = ViewModel()
    var body: some Scene {
        WindowGroup {
            RecordButton(viewModel: viewModel)
//            Display(active: false, title: "active")
//                .environmentObject(viewModel)
        }
    }
}

struct Truth_O_MeterApp_Previews: PreviewProvider {
    static var previews: some View {
        RecordButton(viewModel: ViewModel())
    }
}
