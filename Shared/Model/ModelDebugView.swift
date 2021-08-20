//
//  ModelDebugView.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 16/08/2021.
//

import SwiftUI

struct ModelDebugView: View {
    @ObservedObject var truthViewModel: ViewModel

    var body: some View {
        VStack {
            Picker("", selection: $truthViewModel.stateIndex) {
                Text("wait").tag(0)
                Text("listen").tag(1)
                Text("analyse").tag(2)
                Text("show").tag(3)
            }
            .pickerStyle(SegmentedPickerStyle())
            Text("state \(truthViewModel.stateName) move=\(String(truthViewModel.activeDisplay))")
        }
    }
}

struct ModelDebugView_Previews: PreviewProvider {
    static var previews: some View {
        ModelDebugView(truthViewModel: ViewModel())
    }
}
