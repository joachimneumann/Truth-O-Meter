//
//  MainView.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 27/08/2021.
//

import SwiftUI

private struct ContentView: View {
    @EnvironmentObject private var preferences: Preferences
    @State private var displayColorful = false
    @State private var showAnalysisView = false
    @State private var showSmartButton = true
    @State private var showStampView = false
    @State private var stampTop: String = ""
    @State private var stampBottom: String? = nil
    @State private var smartButtonResetToken = UUID()
    @State private var measuredDisplaySize: CGSize = .zero
    @State private var fixedDisplayWidth: CGFloat? = nil

    private var isIPad: Bool {
#if os(iOS)
        UIDevice.current.userInterfaceIdiom == .pad
#else
        false
#endif
    }

    private func iPadSmartButtonSize(for containerSize: CGSize) -> CGFloat? {
#if os(iOS)
        guard isIPad else { return nil }
        let shortestSide = min(containerSize.width, containerSize.height)
        return min(280, shortestSide * 0.34)
#else
        return nil
#endif
    }

    private var iPadStampScale: CGFloat {
        isIPad ? 0.65 : 1.0
    }

    private func iPadLandscapeSmartButtonHorizontalPadding(for containerSize: CGSize) -> CGFloat {
#if os(iOS)
        guard isIPad else { return 0 }
        return containerSize.width > containerSize.height ? 24 : 0
#else
        return 0
#endif
    }

    private func lockDisplayWidthIfNeeded(_ size: CGSize) {
        guard fixedDisplayWidth == nil, size.width > 0 else { return }
        fixedDisplayWidth = size.width
    }

    private var analysisStatusView: some View {
        VStack {
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
        .frame(width: fixedDisplayWidth)
    }
    
    var body: some View {
        GeometryReader { geometry in
            let containerSize = geometry.size
            VStack {
                VStack {
                    PreferencesButton()
                        .opacity(displayColorful ? 0.0 : preferences.preferencesButtonOpacity)
                        .animation(.easeIn(duration: 0.1), value: displayColorful)
    #if targetEnvironment(macCatalyst)
                        .padding(.top, 20.0)
    #endif
                        .padding(.trailing, 10.0)
                }
                VStack {
                    DisplayView(
                        title: $preferences.title,
                        colorful: displayColorful,
                        editTitle: false,
                        activeColor: preferences.primaryColor,
                        passiveColor: preferences.lightGray,
                        gray: preferences.gray)
                        .frame(width: fixedDisplayWidth)
                        .captureSize(in: $measuredDisplaySize)
                        .task(id: measuredDisplaySize) {
                            lockDisplayWidthIfNeeded(measuredDisplaySize)
                        }
                    Group {
                        if showAnalysisView {
                            analysisStatusView
                        } else {
                            analysisStatusView.hidden()
                        }
                    }
                    Spacer()
                    ZStack {
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
                            .id(smartButtonResetToken)
                            .padding()
                            .frame(
                                width: iPadSmartButtonSize(for: containerSize),
                                height: iPadSmartButtonSize(for: containerSize)
                            )
                            .padding(.horizontal, iPadLandscapeSmartButtonHorizontalPadding(for: containerSize))
                            .opacity(showSmartButton ? 1 : 0)
                            .allowsHitTesting(showSmartButton)

                        Stamp(stampTop, stampBottom, color: preferences.primaryColor)
                            .scaleEffect(iPadStampScale)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 12)
                            .opacity(showStampView ? 1 : 0)
                            .allowsHitTesting(showStampView)
                            .onTapGesture {
                                Needle.shared.active(false, strongNoise: false)
                                Needle.shared.setValue(0.5)
                                showStampView = false
                                showSmartButton = true
                                displayColorful = false
                                smartButtonResetToken = UUID()
                            }
                    }
                    Spacer()
                }
                .padding()
            }
        }
    }
}

private struct PreferencesButton: View {
    @EnvironmentObject private var preferences: Preferences
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
    @Environment(\.colorScheme) private var colorScheme
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
        .navigationViewStyle(StackNavigationViewStyle())
        .environmentObject(Preferences(colorScheme: colorScheme))
        .accentColor(colorScheme == .light ? .blue : .white)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
