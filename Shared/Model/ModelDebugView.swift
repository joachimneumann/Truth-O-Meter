//
//  ModelDebugView.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 16/08/2021.
//

import SwiftUI

struct ModelDebugView: View {
    @ObservedObject var truthViewModel: TruthViewModel

    @State private var pickerIndex: Int = 0
    var body: some View {
        VStack {
            Picker("", selection: $pickerIndex) {
                Text("wait").tag(0)
                Text("listen").tag(1)
                Text("analyse").tag(2)
                Text("show").tag(3)
            }
            .pickerStyle(SegmentedPickerStyle())
            .onChange(of: pickerIndex) { tag in
                switch tag {
                case 0:
                    truthViewModel.setState(.wait)
                case 1:
                    truthViewModel.setState(.listen)
                case 2:
                    truthViewModel.setState(.analyse)
                case 3:
                    truthViewModel.setState(.show)
                default:
                    ()
                }
            }
            Text("state \(truthViewModel.stateName) move=\(String(truthViewModel.activeDisplay))")
        }
    }
}

struct ModelDebugView_Previews: PreviewProvider {
    static var previews: some View {
        ModelDebugView(truthViewModel: TruthViewModel())
    }
}
