////
////  RecordButton.swift
////  Truth-O-Meter
////
////  Created by Joachim Neumann on 14/11/2020.
////
//
//
//import SwiftUI
//import Combine
//
//let innerRadius:CGFloat = 0.88
//let innerRect:CGFloat = 0.4
//
//
//struct ShowView: View {
//    @ObservedObject var viewModel: ViewModel
//    var body: some View {
//        VStack {
//            Spacer()
//            HStack {
//                Spacer()
////                Stamp(texts: viewModel.settings.currentTheme.result(precision: viewModel.precision))
////                    .onTapGesture {
////                        viewModel.setState(.wait)
////                    }
//                Spacer()
//            }
//            Spacer()
//        }
//        .aspectRatio(1.0, contentMode: .fill)
//    }
//}
//
//
//struct ControlView: View {
//    @ObservedObject var viewModel: ViewModel
//    var body: some View {
//        
//        let diskViewModel = DiskViewModel(
//            callback: viewModel.pressed,
//            isSetting: viewModel.isSettingsState)
//        RingView(width: 10, totalTime: 2, callback: viewModel.endOfListening)
//        AllDisksView(diskViewModel: diskViewModel)
//            .padding(15)
////        GeometryReader { (geo) in
////            let lineWidth = 0.05 * min(geo.size.width, geo.size.height)
////            VStack {
////                ZStack {
////                    switch(viewModel.state) {
////                    case .wait, .listen:
////                        if viewModel.isListening {
////                            RingView(width: lineWidth, totalTime: 2, callback: viewModel.endOfListening)
////                        } else {
////                            Circle()
////                                .stroke(C.color.lightGray, lineWidth: lineWidth)
////                        }
////                        AllDisksView(diskViewModel: diskViewModel)
////                            .padding(lineWidth*1.5)
//////                            .padding(geo.size.width * 0.25)
////                    case .analyse:
////                        EmptyView()
////                    case .show:
////                        ShowView(viewModel: viewModel)
////                    case .settings:
////                        HStack {
////                            Spacer()
////                            Text("Settings (not displayed)")
////                            Spacer()
////                        }
////                    }
////                }
//////                .aspectRatio(contentMode: .fit)
//////                Text("ControlView: state = \(viewModel.state.description())")
////            }
////        }
//    }
//}
//
//
//struct ControlView_Previews : PreviewProvider {
//    static var previews: some View {
//        let viewModel = ViewModel()
//        viewModel.setState(.wait)
//        return VStack {
//            Spacer(minLength: 50)
//            ModelDebugView(viewModel: viewModel)
//            Spacer()
//            ControlView(viewModel: viewModel)
//            Spacer()
//        }
//    }
//}
//
