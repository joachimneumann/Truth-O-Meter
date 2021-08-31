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
    @State var buttonModel = ButtonModel(isSetting: true)
    @State var pale: Bool = false
    @State var circle: Bool = true
    @State var gray: Bool = false
    func f() {}
    var body: some Scene {
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
                AllDisksView(isSetting: false, callback: buttonModel.buttonPressedWith(_:))
//                SmartButton()
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
