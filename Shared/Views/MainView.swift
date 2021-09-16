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
            VStack(alignment: .trailing) {
                NavigationLink(destination: SettingsView()) {
                    Image("settings")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .padding(.trailing, 5)
                }
                .padding()
                .padding(.trailing, UIDevice.current.hasNotch ? 50 : 0)
                .padding(.top, UIDevice.current.hasNotch ? 0 : 20)
                .background(Color.yellow.opacity(0.2))
                ContentView()
            }
            .ignoresSafeArea()
            .navigationBarHidden(true)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(Settings())
    }
}

extension UIDevice {
    var hasNotch: Bool {
        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        let bottom = keyWindow?.safeAreaInsets.bottom ?? 0
        return bottom > 0
    }
}
