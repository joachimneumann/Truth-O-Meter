//
//  MainView.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 27/08/2021.
//

import SwiftUI
import NavigationStack

struct SettingsIcon: View {
    @Binding var isHidden: Bool
    var body: some View {
        if !isHidden {
            PushView(destination: SettingsView()) {
                Image("settings")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30.0, height: 30.0)
                    .padding()
            }
        }
    }
}

struct AnalysisView: View {
    @EnvironmentObject var settings: Settings
    @Binding var showStampView: Bool
    @Binding var showAnalysisView: Bool
    
    func animationFinished() {
        showAnalysisView = false
        showStampView = true
    }
    var body: some View {
        VStack{
            HorizontalProgressBar(animationFinished: animationFinished)
                .frame(height: 5)
                .padding(.top, 10)
                .padding(.leading, 20)
                .padding(.trailing, 20)
            Text("Analysing...")
                .font(.headline)
                .foregroundColor(C.color.gray)
        }
    }
}


struct MainView: View {
    @EnvironmentObject var settings: Settings
    @State private var displayColorful = false
    @State private var showAnalysisView = false
    @State private var showStampView = false
    
    var body: some View {
        NavigationStackView() {
            ZStack(alignment: .bottomTrailing) {
                VStack {
                    DisplayView(colorful: displayColorful, editTitle: false)
                    if showAnalysisView {
                        AnalysisView(showStampView: $showStampView, showAnalysisView: $showAnalysisView)
                    }
                    SmartButtonView(displayColorful: $displayColorful, showAnalysisView: $showAnalysisView, showStampView: $showStampView)
                    Spacer()
                }
                .padding(40)
                SettingsIcon(isHidden: $displayColorful)
                    .padding(0)
            }
            .edgesIgnoringSafeArea(.bottom)
            .accentColor(C.color.gray)
        }
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
