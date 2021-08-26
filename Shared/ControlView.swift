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


struct AnalyseView: View {
    var viewModel: ViewModel

    @State private var value: CGFloat = 0.0
    private let timer = Timer.publish(every: C.Timing.analyseTimeIncrement, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack {
            Spacer()
            HorizontalProgressBar(value: value)
                .onReceive(timer) { input in
                    value += CGFloat(C.Timing.analyseTimeIncrement/viewModel.settings.analysisTime)
                    if value >= 1.0 {
                        viewModel.setState(.show)
                    }
                }
            Text("Analysing...")
                .font(.headline)
                .foregroundColor(C.Colors.gray)
            Spacer()
        }
        .aspectRatio(1.0, contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
        .padding()
    }
}

struct ShowView: View {
    @ObservedObject var viewModel: ViewModel
    var body: some View {
        VStack {
            Spacer()
            Stamp(texts: viewModel.settings.currentTheme.stampTexts)
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
                    AnalyseView(viewModel: viewModel)
                        .padding(geo.size.width * 0.1)
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

