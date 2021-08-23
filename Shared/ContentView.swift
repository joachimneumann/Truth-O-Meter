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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ViewModel()
        //        VStack {
        //            ModelDebugView(viewModel: viewModel)
        //            ContentView(viewModel: viewModel)
        //        }
        ContentView(viewModel: viewModel)
    }
}

struct TheContentView: View {
    @ObservedObject var viewModel: ViewModel
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Display(viewModel: viewModel)
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
                        NavigationLink(destination: SettingsView(viewModel: viewModel)) {
                            SettingsIcon(viewModel: viewModel)
                        }
                        .navigationBarHidden(true)
                    }
                }
            }
        }
        .accentColor(C.Colors.gray)
    }
}
