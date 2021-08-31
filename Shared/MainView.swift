//
//  MainView.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 27/08/2021.
//

import SwiftUI

struct TheMainView: View {
    @ObservedObject var viewModel: ViewModel
    @State var title = "ccc"
    var body: some View {
        print("redrawing TheContentView")
        return ZStack {
            ZStack(alignment: .bottomTrailing){
                VStack {
                    VStack {
                        switch(viewModel.state) {
                        case .analyse:
                            VStack {
                                DisplayView(title: $title, colorful: true)
                                AnalyseView(viewModel: viewModel)
                                    .padding(.leading, 20)
                                    .padding(.trailing, 20)
                            }
                        default:
                            VStack {
                                DisplayView(title: $title, colorful: true)
                            }
                        }
                    }
                        .padding(.top, 30)
                        .padding()
                    Spacer()
//                    ControlView(viewModel: viewModel)
                        .aspectRatio(contentMode: .fit)
                    Spacer()
                }
                SettingsIcon(viewModel: viewModel)
            }
        }
        .ignoresSafeArea()
        .accentColor(C.color.gray)
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
//                    viewModel.setView(.settings)
                }
        }
    }
}

struct AnalyseView: View {
    var viewModel: ViewModel

    @State private var value: CGFloat = 0.0
    private let timer = Timer.publish(every: C.timing.analyseTimeIncrement, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack{
            HorizontalProgressBar(value: value)
                .frame(height: 5)
                    .onReceive(timer) { input in
                        value += CGFloat(C.timing.analyseTimeIncrement/100000)//Settings.shared.analysisTiming.time())
                        if value >= 1.0 {
                            viewModel.setState(.show)
                        }
                    }
                .padding(.top, 10)
            Text("Analysing...")
                .font(.headline)
                .foregroundColor(C.color.gray)
        }
    }
}


struct MainView: View {
    @EnvironmentObject var settings: Settings
    @State private var showDisplay = true
    @State private var displayColorful = false
    @State private var showSmartButton = true
    @State private var showAnalysis = false

    var body: some View {
        VStack {
            if showDisplay {
                DisplayView(title: $settings.title, colorful: displayColorful)
            }
            if showSmartButton {
                SmartButtonView()
            }
        }
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
