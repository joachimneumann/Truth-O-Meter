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
        NavigationView {
            VStack {
                Display(viewModel: viewModel)
//                    .background(Color.green)
                    .padding(20)
                Spacer()
                ControlView(viewModel: viewModel)
                    .padding(20)
                Spacer()
                HStack {
                    Spacer()
                    SettingsIcon()
                }
            }
//            .background(Color.blue)
            .navigationBarHidden(true)
            .ignoresSafeArea()
        }
    }
}


struct SettingsIcon: View {
    var body: some View {
            NavigationLink (destination: SettingsView()){
                Image("settings")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30.0)
                    .padding()
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ViewModel()
        ContentView(viewModel: viewModel)
    }
}
