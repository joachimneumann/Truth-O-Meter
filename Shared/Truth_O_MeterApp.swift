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
        let truthViewModel = TruthViewModel()
        WindowGroup {
            VStack {
                ModelDebugView(truthViewModel: truthViewModel)
                Display(truthViewModel: truthViewModel)
            }
        }
    }
}

struct Truth_O_MeterApp_Previews: PreviewProvider {
    static var previews: some View {
        TruthView(truthViewModel: TruthViewModel())
    }
}
