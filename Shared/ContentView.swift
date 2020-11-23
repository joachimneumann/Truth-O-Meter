//
//  ContentView.swift
//  Shared
//
//  Created by Joachim Neumann on 11/10/20.
//

import SwiftUI


struct ContentView: View {
    var body: some View {
        ZStack(alignment: .topTrailing) {
//            Settings()
//                .brightness(/*@START_MENU_TOKEN@*/0.60/*@END_MENU_TOKEN@*/)
            VStack {
                Spacer()
                Display(active: true, title: "Truth")
                Spacer()
//                RecordButton()
                Spacer()
//                TrueButton(nextTarget: TruthModel.shared.nextTarget, truthButtonWidth: TruthButtonWidth(), title: "Analyse")
                Spacer()
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

//struct Settings: View {
//    var body: some View {
//        NavigationLink (destination: SettingsView()){
//            Image("settings")
//                .resizable()
//                .scaledToFit()
//                .frame(width: 25.0)
//                .cornerRadius(5)
//                .padding(.trailing, 5)
//                .padding(.top, 10)
//        }
//
//
//        NavigationView {
//        Image("settings")
//            .resizable()
//            .frame(width: 30, height: 30, alignment: .center)
//            .gesture(TapGesture()
//                .onEnded { _ in
//                    NavigationLink(destination: SettingsView())
//            )
//        }
//    }
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
