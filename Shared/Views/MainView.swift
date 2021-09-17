//
//  MainView.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 27/08/2021.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var preferences: Preferences
    @State private var displayColorful = false
    @State private var showAnalysisView = false
    @State private var showSmartButton = true
    @State private var showStampView = false
    
    let analyseTitleFont: Font = Font.system(size: UIScreen.main.bounds.width * 0.04).bold()
    
    var body: some View {
        VStack {
            DisplayView(colorful: displayColorful, editTitle: false, activeColor: preferences.colors.bullshitRed, passiveColor: preferences.colors.lightGray, darkColor: preferences.colors.gray)
            if showAnalysisView {
                HorizontalProgressBar(
                    activeColor: preferences.colors.lightGray,
                    passiveColor: preferences.colors.lightGray.opacity(0.7),
                    animationTime: preferences.analysisTime)
                Text("Analysing...")
                    .font(analyseTitleFont)
                    .foregroundColor(preferences.colors.gray)
            }
            Spacer()
            if showSmartButton {
                SmartButtonView(
                    color: preferences.colors.bullshitRed,
                    gray: preferences.colors.lightGray,
                    paleColor: preferences.colors.paleBullshitRed) { p in
                        Needle.shared.active(true, strongNoise: true)
                        displayColorful = true
                        showAnalysisView = true
                        showSmartButton = false
                        DispatchQueue.main.asyncAfter(deadline: .now() + preferences.analysisTime) {
                            Needle.shared.active(true, strongNoise: false)
                            showAnalysisView = false
                            showStampView = true
                        }
                    }
                    .padding()
            }
            if showStampView {
                Stamp(preferences.stampTop, preferences.stampBottom)
                    .onTapGesture {
                        Needle.shared.setValue(0.5)
                        Needle.shared.active(false, strongNoise: false)
                        showStampView = false
                        showSmartButton = true
                        displayColorful = false
                    }
            }
            Spacer()
        }
        .padding()
    }
}

struct MainView: View {
    var body: some View {
        NavigationView {
            VStack(alignment: .trailing) {
                NavigationLink(destination: PreferencesView()) {
                    Image("settings")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .padding(.trailing, 5)
                }
                .padding()
                .padding(.trailing, UIDevice.current.hasNotch ? 10 : 0)
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
            .environmentObject(Preferences())
    }
}

extension UIDevice {
    var hasNotch: Bool {
        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        let bottom = keyWindow?.safeAreaInsets.bottom ?? 0
        return bottom > 0
    }
}
