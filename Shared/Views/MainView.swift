//
//  MainView.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 27/08/2021.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var preferences: Preferences
    @State private var displayColorful = false
    @State private var showAnalysisView = false
    @State private var showSmartButton = true
    @State private var showStampView = false
    @State private var stampTop: String = ""
    @State private var stampBottom: String? = nil
    
    let analyseTitleFont: Font = Font.system(size: UIScreen.main.bounds.width * 0.04).bold()
    
    var body: some View {
        VStack {
            PreferencesButton()
                .opacity(displayColorful ? 0.0 : preferences.preferencesButtonOpacity)
                .animation(.easeIn(duration: 0.1), value: displayColorful)
#if targetEnvironment(macCatalyst)
                .padding(.top, 20)
#endif
                .padding(.trailing, UIDevice.current.hasNotch ? 10 : 0)
            DisplayView(
                title: $preferences.title,
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
#if targetEnvironment(macCatalyst)
                    .font(.title)
#else
                    .font(.headline)
#endif
                    .foregroundColor(preferences.lightGray)
            }
            Spacer()
            if showSmartButton {
                SmartButtonView(
                    color: preferences.primaryColor,
                    gray: preferences.lightGray,
                    paleColor: preferences.secondaryColor,
                    listenTime: preferences.listenTime,
                    analysisTime: preferences.analysisTime,
                    displayColorful: $displayColorful) { precision in
                        stampTop = preferences.stampTop(precision)
                        stampBottom = preferences.stampBottom(precision)
                        Needle.shared.active(true, strongNoise: true)
                        displayColorful = true
                        showAnalysisView = true
                        showSmartButton = false
                        DispatchQueue.main.asyncAfter(deadline: .now() + preferences.analysisTime) {
                            Needle.shared.active(true, strongNoise: false)
                            displayColorful = true
                            showAnalysisView = false
                            showStampView = true
                        }
                    }
                    .padding()
            }
            if showStampView {
                Stamp(stampTop, stampBottom, color: preferences.primaryColor)
                    .onTapGesture {
                        Needle.shared.active(false, strongNoise: false)
                        Needle.shared.setValue(0.5)
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

struct PreferencesButton: View {
    @EnvironmentObject var preferences: Preferences
    var body: some View {
        HStack {
            Spacer()
            NavigationLink(destination: PreferencesView()) {
                Image(preferences.preferencesButton)
                    .resizable()
                    .frame(width: 30, height: 30)
                    .padding(.trailing, 5)
            }
            .padding()
        }
    }
}

struct MainView: View {
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        NavigationView {
            ContentView()
                .onAppear() {
                    Needle.shared.active(false, strongNoise: false)
                    Needle.shared.setValue(0.5)
                }
                .ignoresSafeArea()
                .navigationBarHidden(true)
        }
        .environmentObject(Preferences(colorScheme: colorScheme))
        .accentColor(colorScheme == .light ? .blue : .white)
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
