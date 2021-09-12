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
    @State private var showAnalysisView = false
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
                                    activeColor: C.color.lightGray,
                                    passiveColor: C.color.lightGray.opacity(0.7),
                                    animationTime: settings.analysisTime)
                                    .frame(height: 2*C.lw1())
                                Text("Analysing...")
                                    .font(.analyseTitle)
                                    .foregroundColor(C.color.gray)
//                            } else {
//                                Rectangle()
//                                    .frame(width: C.h * 0.05, height: C.h * 0.10, alignment: .center)
//                                    .foregroundColor(.blue)
                            }
                            Spacer(minLength: C.h * 0.05)
                            SmartButtonView(
                                displayColorful: $displayColorful,
                                showAnalysisView: $showAnalysisView,
                                showStampView: $showStampView)
                                .background(Color.green.opacity(0.2))
                                .aspectRatio(contentMode: .fit)
                            Spacer(minLength: 0)
                        }
                    }
                    .padding(.horizontal, C.w * 0.1)
                    .padding(.vertical, C.h * 0.05)
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
