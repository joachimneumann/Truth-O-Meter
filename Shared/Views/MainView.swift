//
//  MainView.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 27/08/2021.
//

import SwiftUI


struct ContentView: View {
    @EnvironmentObject private var settings: Settings
    @State private var displayColorful = false
    @State private var showAnalysisView = false
    @State private var showStampView = false
    
    func analysisFinished() {
        showAnalysisView = false
        showStampView = true
    }
    
    var body: some View {
        VStack {
            DisplayView(colorful: displayColorful, editTitle: false, activeColor: C.color.bullshitRed, passiveColor: C.color.lightGray, darkColor: C.color.gray)
            if showAnalysisView {
                HorizontalProgressBar(
                    animationFinished: analysisFinished,
                    activeColor: C.color.lightGray,
                    passiveColor: C.color.lightGray.opacity(0.7),
                    animationTime: settings.analysisTime)
                Text("Analysing...")
                    .font(.analyseTitle)
                    .foregroundColor(C.color.gray)
            }
            Spacer()
            SmartButtonView(
                displayColorful: $displayColorful,
                showAnalysisView: $showAnalysisView,
                showStampView: $showStampView)
            //.background(Color.green.opacity(0.2))
                .aspectRatio(contentMode: .fit)
            Spacer()
        }
        .padding()
    }
}

struct MainView: View {
    var body: some View {
        NavigationView {
            ContentView()
            .navigationBarItems(
                trailing:
                    NavigationLink(destination: SettingsView()) {
                        Image("settings")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .padding(10)
                            .padding(.trailing, 5)
                    }
            )
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(Settings())
    }
}
