//
//  ModelDebugView.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 16/08/2021.
//

import SwiftUI

struct ModelDebugView: View {
    @ObservedObject var viewModel: ViewModel
    @EnvironmentObject var needle: Needle

    var body: some View {
        VStack {
            Picker("", selection: $viewModel.stateIndex) {
                Text("wait").tag(0)
                Text("listen").tag(1)
                Text("analyse").tag(2)
                Text("show").tag(3)
                Text("settings").tag(4)
            }
            .pickerStyle(SegmentedPickerStyle())
            Text("state \(viewModel.stateName) grayedOut=\(String(needle.grayedOut))")
        }
        .padding(.bottom, 20)
    }
}

struct ModelDebugView_Previews: PreviewProvider {
    static var previews: some View {
        ModelDebugView(viewModel: ViewModel(Needle()))
    }
}
