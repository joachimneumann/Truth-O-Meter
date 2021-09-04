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
    private static let childID = "SetingsView"
    @EnvironmentObject private var navigationStack: NavigationStack
    
    var body: some View {
        VStack {
            if !isHidden {
                Image("settings")
                    .renderingMode(.original)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30.0, height: 30.0)
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
    @EnvironmentObject private var settings: Settings
    @EnvironmentObject private var navigationStack: NavigationStack
    @State private var displayColorful = false
    @State private var showAnalysisView = false
    @State private var showStampView = false
    
    var body: some View {
        NavigationStackView(navigationStack: navigationStack) {
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
