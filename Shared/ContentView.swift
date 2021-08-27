//
//  ContentView.swift
//  Shared
//
//  Created by Joachim Neumann on 11/10/20.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ViewModel
    var body: some View {
        
        #if os(macOS)
        let w : CGFloat = 375
        let h : CGFloat = 667
        TheContentView(viewModel: viewModel)
            .frame(minWidth: w, minHeight: h)
            .frame(maxWidth: w, maxHeight: h)
            .background(Color.white)
        #endif
        
        #if os(iOS)
        TheContentView(viewModel: viewModel)
        #endif
        
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

struct TheContentView: View {
    @ObservedObject var viewModel: ViewModel
    @State private var isShowingDetailView = false {
        didSet {
            viewModel.settingsConfigutation(.outer)
        }
    }
    var body: some View {
        print("redrawing TheContentView")
        let navViewContent = ZStack {
            VStack {
                VStack {
                    switch(viewModel.state) {
                    case .analyse:
                        VStack {
                            Display(colorful: viewModel.displayBackgroundColorful, title: viewModel.settings.currentTheme.title)
                            AnalyseView(viewModel: viewModel)
                        }
                    default:
                        VStack {
                            Display(colorful: viewModel.displayBackgroundColorful, title: viewModel.settings.currentTheme.title)
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
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    NavigationLink(
                        destination: SettingsView(viewModel: viewModel),
                        isActive: $viewModel.isShowingSettings) {
                        SettingsIcon(viewModel: viewModel)
                    }
                    .navigationBarHidden(true)
                }
            }
        }
        .accentColor(C.Colors.gray)

        if UIDevice.current.userInterfaceIdiom == .pad {
            return AnyView(NavigationView {
                EmptyView() // empty sidebar (for iPad)
                navViewContent
            })
        } else{
            return AnyView(NavigationView {
                navViewContent
            }
            .navigationViewStyle(StackNavigationViewStyle())
            )
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ViewModel()
        //                VStack {
        //                    ModelDebugView(viewModel: viewModel)
        //                    ContentView(viewModel: viewModel)
        //                }
        ContentView(viewModel: viewModel)
    }
}
