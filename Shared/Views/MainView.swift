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
            DisplayView(
                colorful: displayColorful,
                editTitle: false,
                activeColor: preferences.primaryColor,
                passiveColor: preferences.lightGray,
                gray: preferences.gray)
            if showAnalysisView {
                HorizontalProgressBar(
                    activeColor: preferences.lightGray,
                    passiveColor: preferences.lightGray.opacity(0.7),
                    animationTime: preferences.analysisTime)
                Text("Analysing...")
                    .font(analyseTitleFont)
                    .foregroundColor(preferences.gray)
            }
            Spacer()
            if showSmartButton {
                SmartButtonView(
                    color: preferences.primaryColor,
                    gray: preferences.lightGray,
                    paleColor: preferences.secondaryColor) { p in
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
                Stamp(preferences.stampTop, preferences.stampBottom, color: preferences.primaryColor)
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
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        let preferences = Preferences(preferredColorScheme: colorScheme)
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
                    .environmentObject(preferences)
            }
            .ignoresSafeArea()
            .navigationBarHidden(true)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

extension UIDevice {
    var hasNotch: Bool {
        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        let bottom = keyWindow?.safeAreaInsets.bottom ?? 0
        return bottom > 0
    }
}
