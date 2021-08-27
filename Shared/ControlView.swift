//
//  RecordButton.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 14/11/2020.
//


import SwiftUI
import Combine

let innerRadius:CGFloat = 0.88
let innerRect:CGFloat = 0.4


struct ShowView: View {
    @ObservedObject var viewModel: ViewModel
    var body: some View {
        VStack {
            Spacer()
            Stamp(texts: viewModel.settings.currentTheme.results[viewModel.precision]!)
                .onTapGesture {
                    viewModel.setState(.wait)
                }
            Spacer()
        }
        .aspectRatio(1.0, contentMode: .fill)
    }
}


struct ControlView: View {
    @ObservedObject var viewModel: ViewModel
    var body: some View {
        GeometryReader { (geo) in
            ZStack {
                switch(viewModel.state) {
                case .wait:
                    RecordButton(viewModel: viewModel)
                        .padding(geo.size.width * 0.25)
                case .listen:
                    RecordButton(viewModel: viewModel)
                        .padding(geo.size.width * 0.25)
                case .analyse:
                    EmptyView()
                case .show:
                    ShowView(viewModel: viewModel)
                        .padding(geo.size.width * 0.0)
                case .settings:
                    HStack {
                        Spacer()
                        Text("Settings (not displayed)")
                        Spacer()
                    }
                }
            }
            .aspectRatio(contentMode: .fit)
        }
    }
}


struct ControlView_Previews : PreviewProvider {
    static var previews: some View {
        let viewModel = ViewModel()
        viewModel.setState(.show)
        return VStack {
            Spacer()
            ModelDebugView(viewModel: viewModel)
            Spacer()
            ControlView(viewModel: viewModel)
            Spacer()
        }
    }
}

