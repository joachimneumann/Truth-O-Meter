//
//  MainView.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 27/08/2021.
//

import SwiftUI

struct TheMainView: View {
    @ObservedObject var viewModel: ViewModel
    var body: some View {
        print("redrawing TheContentView")
        return ZStack {
            ZStack(alignment: .bottomTrailing){
                VStack {
                    VStack {
                        switch(viewModel.state) {
                        case .analyse:
                            VStack {
                                DisplayView(viewModel: viewModel)
                                AnalyseView(viewModel: viewModel)
                                    .padding(.leading, 20)
                                    .padding(.trailing, 20)
                            }
                        default:
                            VStack {
                                DisplayView(viewModel: viewModel)
                            }
                        }
                    }
                        .padding(.top, 30)
                        .padding()
                    Spacer()
                    ControlView(viewModel: viewModel)
                        .aspectRatio(contentMode: .fit)
                    Spacer()
                }
                SettingsIcon(viewModel: viewModel)
            }
        }
        .ignoresSafeArea()
        .accentColor(C.Colors.gray)
    }
}

struct SettingsIcon: View {
    @ObservedObject var viewModel: ViewModel
    var body: some View {
        if viewModel.state == .wait {
            Image("settings")
                .resizable()
                .scaledToFit()
                .frame(width: 30.0, height: 30.0)
                .padding()
                .onTapGesture {
                    viewModel.setView(.settings)
                }
        }
    }
}

struct AnalyseView: View {
    var viewModel: ViewModel

    @State private var value: CGFloat = 0.0
    private let timer = Timer.publish(every: C.Timing.analyseTimeIncrement, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack{
            HorizontalProgressBar(value: value)
                .frame(height: 5)
                    .onReceive(timer) { input in
                        value += CGFloat(C.Timing.analyseTimeIncrement/viewModel.settings.analysisTiming.time())
                        if value >= 1.0 {
                            viewModel.setState(.show)
                        }
                    }
                .padding(.top, 10)
            Text("Analysing...")
                .font(.headline)
                .foregroundColor(C.Colors.gray)
        }
    }
}


struct MainView: View {
    @ObservedObject var viewModel: ViewModel
    enum ViewEnum {
        case main, settings, detail
    }
    var body: some View {
        switch viewModel.view {
        case .main:
            TheMainView(viewModel: viewModel)
                .padding(.top, 0)
        case .settings:
            SettingsView(viewModel: viewModel)
                .padding(.top, 20)
        case .detail:
            DetailView(viewModel: viewModel)
                .padding(.top, 20)
        }
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ViewModel()
        MainView(viewModel: viewModel)
    }
}
