//
//  ContentView.swift
//  Shared
//
//  Created by Joachim Neumann on 11/10/20.
//

import SwiftUI


struct ContentView: View {
    @EnvironmentObject var userSettings: UserSettings
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Settings()
                .brightness(/*@START_MENU_TOKEN@*/0.60/*@END_MENU_TOKEN@*/)
            VStack {
                Display()
                    .padding(.top, 10)
                Spacer()
                TrueButton()
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, maxHeight: 60)
                    .padding (.all, 20)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct Settings: View {
    var body: some View {
        NavigationLink (destination: SettingsView()){
            Image("vertical_ellipsis")
                .resizable()
                .scaledToFit()
                .frame(width: 25.0)
                .cornerRadius(5)
                .padding(.trailing, 5)
                .padding(.top, 10)
        }
//
//
//        NavigationView {
//        Image("vertical_ellipsis")
//            .resizable()
//            .frame(width: 30, height: 30, alignment: .center)
//            .gesture(TapGesture()
//                .onEnded { _ in
//                    NavigationLink(destination: SettingsView())
//            )
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(UserSettings())
    }
}
