////
////  RecordButton.swift
////  Truth-O-Meter
////
////  Created by Joachim Neumann on 14/11/2020.
////
//
//import SwiftUI
//import GameKit // for Audio
//#if os(macOS)
//import AVFoundation // for sound on Mac
//#endif
//
//struct RecordButton: View {
//    @ObservedObject var viewModel: ViewModel
//
//    struct ListenView: View {
//        var viewModel: ViewModel
//        var measures: Measures
//
//        @State private var value: CGFloat = 0.0
//        private let timer = Timer.publish(every: C.timing.listeningTimeIncrement, on: .main, in: .common).autoconnect()
//
//        var body: some View {
//            if value == 0 { AudioServicesPlaySystemSound(C.sounds.startRecording) }
//            return ZStack {
//                Circle()
//                    .stroke(C.color.lightGray, lineWidth:measures.outerRingWidth)
//                Circle()
//                    .trim(from: 0, to: value)
//                    .stroke(C.color.bullshitRed, lineWidth:measures.outerRingWidth)
//                    .rotationEffect(Angle(degrees:-90))
//                    .onReceive(timer) { input in
//                        value += CGFloat(C.timing.listeningTimeIncrement/viewModel.settings.listenTiming.time())
//                        if value >= 1.0 {
//                            AudioServicesPlaySystemSound(C.sounds.stopRecording)
//                            viewModel.setState(.analyse)
//                        }
//                    }
//                Rectangle()
//                    .foregroundColor(C.color.bullshitRed)
//                    .cornerRadius(measures.cornerRadius)
//                    .padding(measures.rectanglePadding)
//            }
//        }
//    }
//
//    struct Measures {
//        let outerRingWidth: CGFloat
//        let ringsPadding:   CGFloat
//        let cornerRadius:   CGFloat
//        let rectanglePadding:   CGFloat
//        
//        init(_ diameter: CGFloat) {
//            let radius = diameter / 2
//            let factor:CGFloat = 0.08
//            outerRingWidth   = radius * factor
//            ringsPadding     = radius * factor * 1.5
//            cornerRadius     = radius * 0.12
//            rectanglePadding = radius * 0.6
//        }
//    }
//        
//    var body: some View {
//        print("RecordButton: stampTexts.top = \(viewModel.settings.currentTheme.result(precision: viewModel.precision))")
//        return GeometryReader { (geo) in
//            let measures = Measures(min(geo.size.width, geo.size.height))
//            ZStack {
//                switch(viewModel.state) {
//                case .wait, .settings:
//                    Circle()
//                        .stroke(C.color.lightGray, lineWidth:measures.outerRingWidth)
//                    RingsView(viewModel: viewModel)
//                        .padding(measures.ringsPadding)
//                case .listen:
//                    ListenView(viewModel: viewModel, measures: measures)
//                        .animation(.easeInOut(duration: 2))
//                case .analyse:
//                    EmptyView()
//                case .show:
//                    EmptyView()
//                }
//            }
//        }
//        .aspectRatio(contentMode: .fit)
//    }
//}
//
//struct RecordButton_Previews: PreviewProvider {
//    static var previews: some View {
//        let viewModel = ViewModel()
//        viewModel.setState(.listen)
//        return VStack {
//            ModelDebugView(viewModel: viewModel)
//            RecordButton(viewModel: viewModel)
//                .padding(30)
//            Spacer()
//        }
//    }
//}
