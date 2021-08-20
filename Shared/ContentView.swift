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
                HStack {
                    Spacer()
                    SettingsIcon()
                }
//                .background(Color.yellow)
                Spacer()
                Display(viewModel: viewModel)
                Spacer()
                ControlView(viewModel: viewModel)
                Spacer()
            }
//            .background(Color.blue)
//            .navigationBarTitle("")
//            .navigationBarHidden(true)
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
