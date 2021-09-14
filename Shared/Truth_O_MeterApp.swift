//
//  Truth_O_MeterApp.swift
//  Shared
//
//  Created by Joachim Neumann on 11/10/20.
//

import SwiftUI
import NavigationStack

@main
struct Truth_O_MeterApp: App {
#if targetEnvironment(macCatalyst)
    @UIApplicationDelegateAdaptor var delegate: FSAppDelegate
#endif
    func doNothing() {}
    
    var body: some Scene {
        return WindowGroup {
//            PlaygroundView()
//            StampView(top: "WWWWWWWWWiiiiiiiiiiiii")

//            RingView(width: 10, whenFinished: doNothing)
//                .environmentObject(Settings())
//
            MainView()
                .environmentObject(Settings())
                .environmentObject(NavigationStack())
            
        }
    }
}

#if targetEnvironment(macCatalyst)
class FSSceneDelegate: NSObject, UIWindowSceneDelegate, ObservableObject {
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .forEach { windowScene in
                windowScene.sizeRestrictions?.minimumSize = CGSize(width: C.w, height: C.h)
                windowScene.sizeRestrictions?.maximumSize = CGSize(width: C.w, height: C.h)
            }
    }
}

class FSAppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        let sceneConfig = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
        sceneConfig.delegateClass = FSSceneDelegate.self
        return sceneConfig
    }
}
#endif
