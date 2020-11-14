//
//  ContentView.swift
//  Shared
//
//  Created by Joachim Neumann on 11/10/20.
//

import SwiftUI

enum GuiState {
    case waiting, doneListening, analysing, showingResult
}

struct ContentView: View {
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Settings()
                .brightness(/*@START_MENU_TOKEN@*/0.60/*@END_MENU_TOKEN@*/)
            VStack {
                Display(isActive: true, title: "Truth-O-Meter")
                Spacer()
                RecordButton(isActive: false)
                Spacer()
                TrueButton(nextTarget: TruthModel.shared.nextTarget, truthButtonWidth: TruthButtonWidth(), isActive: true, title: "Analyse")
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
    }
}
