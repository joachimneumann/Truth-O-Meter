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

struct WaitView: View {
    @ObservedObject var viewModel: ViewModel
    var body: some View {
        RecordButton(viewModel: viewModel)
    }
}

struct ListenView: View {
    @ObservedObject var viewModel: ViewModel
    var body: some View {
        RecordButton(viewModel: viewModel)
    }
}

struct AnalyseView: View {
    @ObservedObject var viewModel: ViewModel
    var body: some View {
        VStack {
            Spacer()
            HorizontalProgressBar(value:  viewModel.analyseProgress)
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
            Stamp(texts: viewModel.stampTexts)
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
                    WaitView(viewModel: viewModel)
                        .padding(geo.size.width * 0.25)
                case .listen:
                    ListenView(viewModel: viewModel)
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


struct RecordButton_Previews : PreviewProvider {
    static var previews: some View {
        let viewModel = ViewModel(Needle())
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

