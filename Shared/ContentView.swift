//
//  ContentView.swift
//  Shared
//
//  Created by Joachim Neumann on 11/10/20.
//

import SwiftUI


struct ContentView: View {
    @ObservedObject var truthViewModel: TruthViewModel
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Spacer()
                    SettingsIcon()
                }
//                .background(Color.yellow)
                Spacer()
                Display(truthViewModel: truthViewModel)
                Spacer()
                RecordButton()
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
        let truthViewModel = TruthViewModel()
        ContentView(truthViewModel: truthViewModel)
    }
}
