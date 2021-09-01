//
//  MainView.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 27/08/2021.
//

import SwiftUI

struct SettingsIcon: View {
    @Binding var isHidden: Bool
    @Binding var navigation: NavigationEnum
    var body: some View {
        if !isHidden {
            Image("settings")
                .resizable()
                .scaledToFit()
                .frame(width: 30.0, height: 30.0)
                .padding()
                .onTapGesture {
                    navigation = .settings
                }
        }
    }
}

struct AnalysisView: View {
    @EnvironmentObject var settings: Settings
    @Binding var showStampView: Bool
    @Binding var showAnalysisView: Bool
    @State private var value: CGFloat = 0.0
    private let timer = Timer.publish(every: C.timing.analyseTimeIncrement, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack{
            HorizontalProgressBar(value: value)
                .frame(height: 5)
                    .onReceive(timer) { input in
                        value += CGFloat(C.timing.analyseTimeIncrement/settings.analysisTime)
                        if value >= 1.0 {
                            showAnalysisView = false
                            showStampView = true
                        }
                    }
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
    @Binding var navigation: NavigationEnum
    @State private var displayColorful = false
    @State private var showAnalysisView = false
    @State private var showStampView = false

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack {
                DisplayView(colorful: displayColorful)
                if showAnalysisView {
                    AnalysisView(showStampView: $showStampView, showAnalysisView: $showAnalysisView)
                }
                SmartButtonView(displayColorful: $displayColorful, showAnalysisView: $showAnalysisView, showStampView: $showStampView)
                Spacer()
            }
            SettingsIcon(isHidden: $displayColorful, navigation: $navigation)
        }
        .accentColor(C.color.gray)
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(navigation: .constant(.main))
    }
}
