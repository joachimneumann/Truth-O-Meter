//
//  Truth_O_MeterApp.swift
//  Shared
//
//  Created by Joachim Neumann on 11/10/20.
//

import SwiftUI

@main
struct Truth_O_MeterApp: App {
    @State var pale: Bool = false
    @State var circle: Bool = true
    @State var gray: Bool = false
    
//    private(set) var settings = Settings()
    func f1() {}
    func f2(p: Precision) {}
    var body: some Scene {
        let settings = Settings()
        return WindowGroup {
            #if os(macOS)
//            SmartButtonView(settings: Settings())
//            AllDisksView(isSetting: false, callback: f2)
            NavigationView()
                .environmentObject(settings)
                .frame(minWidth: 375, minHeight: 667)
                .frame(maxWidth: 375, maxHeight: 667)
                .background(Color.white)
            #else
//            DisplayView(colorful: true, editTitle: true)
            NavigationView()
                .environmentObject(settings)
            #endif
        }
    }
}

//                #if os(macOS)
//                let w : CGFloat = 375
//                let h : CGFloat = 667
//                Disks(diskViewModel: diskViewModel)
//                    .padding(100)
////                MainView(viewModel: viewModel)
//                    .frame(minWidth: w, minHeight: h)
//                    .frame(maxWidth: w, maxHeight: h)
//                    .background(Color.white)
//                #else

//                AllDisksView(isSetting: false, callback: buttonModel.buttonPressedWith(_:))
//                SmartButton()
//                DisplayView(colorful: true, title: $title, editTitle: false)
//                MainView(viewModel: viewModel)

//struct Truth_O_MeterApp_Previews: PreviewProvider {
//    static var previews: some View {
//        let viewModel = ViewModel()
//        viewModel.setState(.wait)
//        let diskViewModel = DiskViewModel(
//            callback: viewModel.tap,
//            isSetting: viewModel.isSettingsState)
//        return DisksView(diskViewModel: diskViewModel)
//            .padding(100)
////        MainView(viewModel: viewModel)
//    }
//}
