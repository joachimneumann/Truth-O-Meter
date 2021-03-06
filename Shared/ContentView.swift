//
//  ContentView.swift
//  Shared
//
//  Created by Joachim Neumann on 11/10/20.
//

import SwiftUI


struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Spacer()
                    SettingsIcon()
                }
//                .background(Color.yellow)
                Spacer()
                Display(active: false, title: "Truth-O-Meter")
                Spacer()
                TrueButton(truthButtonWidth: CGFloat(100.0), title: "xx")
                Spacer()
            }
//            .background(Color.blue)
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
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
