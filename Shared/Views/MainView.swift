//
//  MainView.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 27/08/2021.
//

import SwiftUI

struct ContentView: View {
    @Binding var preferences: Preferences
    @State private var displayColorful = false
    @State private var showAnalysisView = false
    @State private var showSmartButton = true
    @State private var showStampView = false
    
    let analyseTitleFont: Font = Font.system(size: UIScreen.main.bounds.width * 0.04).bold()
    
    var body: some View {
        VStack {
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
                    .font(.title)
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
                    displayColorful: $displayColorful) { p in
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
    @State var preferences: Preferences = Preferences()
    var body: some View {
        preferences = Preferences(preferredColorScheme: colorScheme)
        return NavigationView {
            VStack(alignment: .trailing) {
                NavigationLink(destination: PreferencesView(preferences: $preferences)) {
                    Image(colorScheme == .light ? "settings" : "settings.dark")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .padding(.trailing, 5)
                }
                .padding()
#if targetEnvironment(macCatalyst)
                .padding(.top, 20)
#endif
                .padding(.trailing, UIDevice.current.hasNotch ? 10 : 0)
                ContentView(preferences: $preferences)
            }
            .ignoresSafeArea()
            .navigationBarHidden(true)
        }
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
