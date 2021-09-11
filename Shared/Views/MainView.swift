//
//  MainView.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 27/08/2021.
//

import SwiftUI
import NavigationStack

struct SettingsIcon: View {
    @EnvironmentObject private var settings: Settings
    @EnvironmentObject private var navigationStack: NavigationStack
    @Binding var isHidden: Bool
    private static let childID = "SetingsView"
    
    var body: some View {
        VStack {
            if !isHidden {
                Image("settings")
                    .resizable()
                    .scaledToFit()
                    .frame(width: C.w*0.1, height: C.w*0.1)
                    .padding()
                    .onTapGesture {
                        DispatchQueue.main.async {
                            self.navigationStack.push(SettingsView(), withId: Self.childID)
                        }
                    }
            }
        }
    }
}

struct MainView: View {
    @EnvironmentObject private var settings: Settings
    @EnvironmentObject private var navigationStack: NavigationStack
    @State private var displayColorful = false
    @State private var showAnalysisView = true
    @State private var showStampView = false
    let activeColor = C.color.bullshitRed
    let passiveColor = C.color.lightGray
    
    func analysisFinished() {
        showAnalysisView = false
        showStampView = true
    }
    
    var body: some View {
        ZStack {
            NavigationStackView(navigationStack: navigationStack) {
                ZStack(alignment: .bottomTrailing) {
                    VStack {
                        VStack {
                            DisplayView(colorful: displayColorful, editTitle: false, activeColor: C.color.bullshitRed, passiveColor: C.color.lightGray, darkColor: C.color.gray)
                            if showAnalysisView {
                                HorizontalProgressBar(
                                    animationFinished: analysisFinished,
                                    activeColor: activeColor,
                                    passiveColor: passiveColor,
                                    animationTime: settings.analysisTime)
                                    .aspectRatio(40, contentMode: .fit)
                                Text("Analysing...")
                                    .font(.analyseTitle)
                                    .foregroundColor(passiveColor)
                            }
                        }
                        SmartButtonView(
                            displayColorful: $displayColorful,
                            showAnalysisView: $showAnalysisView,
                            showStampView: $showStampView)
                    }
                    SettingsIcon(isHidden: $displayColorful)
                        .padding(0)
                }
                .edgesIgnoringSafeArea(.bottom)
                .accentColor(C.color.gray)
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(Settings())
            .environmentObject(NavigationStack())
    }
}
