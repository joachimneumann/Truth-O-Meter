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
        let truthViewModel = ViewModel()
        WindowGroup {
            VStack {
                ModelDebugView(truthViewModel: truthViewModel)
                RecordButton(truthViewModel: truthViewModel)
            }
        }
    }
}

struct Truth_O_MeterApp_Previews: PreviewProvider {
    static var previews: some View {
        NeedleView(truthViewModel: ViewModel())
    }
}
