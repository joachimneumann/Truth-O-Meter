//
//  Truth_O_MeterApp.swift
//  Shared
//
//  Created by Joachim Neumann on 11/10/20.
//

import SwiftUI

func call() {
    print("call")
}

@main
struct Truth_O_MeterApp: App {
    var body: some Scene {
        let buttonModel = ButtonModel(isSetting: false)
//        let viewModel = ViewModel()
//        let diskViewModel = DiskViewModel(
//            callback: viewModel.pressed,
//            isSetting: viewModel.isSettingsState)
        return WindowGroup {
            VStack {
                #if os(macOS)
                let w : CGFloat = 375
                let h : CGFloat = 667
                Disks(diskViewModel: diskViewModel)
                    .padding(100)
//                MainView(viewModel: viewModel)
//                    .environmentObject(viewModel.needle)
                    .frame(minWidth: w, minHeight: h)
                    .frame(maxWidth: w, maxHeight: h)
                    .background(Color.white)
                #else
                SmartButton(buttonModel: buttonModel)
//                AllDisksView(diskViewModel: diskViewModel)
//                    .padding(100)
//                MainView(viewModel: viewModel)
//                    .environmentObject(viewModel.needle)
                #endif
            }
        }
    }
}

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
////            .environmentObject(viewModel.needle)
//    }
//}
