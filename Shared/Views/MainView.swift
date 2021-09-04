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
                    .frame(width: settings.w*0.1, height: settings.w*0.1)
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

struct AnalysisView: View {
    @EnvironmentObject private var settings: Settings
    @Binding var showStampView: Bool
    @Binding var showAnalysisView: Bool
    
    func analysisFinished() {
        showAnalysisView = false
        showStampView = true
    }
    var body: some View {
        VStack{
            HorizontalProgressBar(animationFinished: analysisFinished)
                .frame(height: settings.w/320*2)
                .padding(.top, 10)
                .padding(.leading, 20)
                .padding(.trailing, 20)
            Text("Analysing...")
                .font(.system(size: settings.w * 0.04))
                .foregroundColor(C.color.gray)
        }
    }
}

struct MainView: View {
    @EnvironmentObject private var settings: Settings
    @EnvironmentObject private var navigationStack: NavigationStack
    @State private var displayColorful = false
    @State private var showAnalysisView = false
    @State private var showStampView = false
    
    var body: some View {
        ZStack {
            NavigationStackView(navigationStack: navigationStack) {
                ZStack(alignment: .bottomTrailing) {
                    VStack {
                        VStack {
                            DisplayView(colorful: displayColorful, editTitle: false)
                            if showAnalysisView {
                                AnalysisView(
                                    showStampView: $showStampView,
                                    showAnalysisView: $showAnalysisView)
                            }
                        }
                        .padding(settings.w*0.09)
                        SmartButtonView(
                            displayColorful: $displayColorful,
                            showAnalysisView: $showAnalysisView,
                            showStampView: $showStampView)
                        Spacer()
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
