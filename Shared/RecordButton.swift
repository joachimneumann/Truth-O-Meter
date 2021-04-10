//
//  RecordButton.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 14/11/2020.
//


import SwiftUI
import Combine

let ringWidth:CGFloat = 0.05
let innerRadius:CGFloat = 0.88
let innerRect:CGFloat = 0.4
var progressDuration = 2.0

struct ListenView: View {
    @ObservedObject var viewModel: ViewModel
    var body: some View {
        GeometryReader { (geometry) in
            let r:CGFloat = min(geometry.size.width, geometry.size.height)
            ZStack{
                Rectangle()
                    .foregroundColor(C.Colors.bullshitRed)
                    .frame(width: r*innerRect, height: r*innerRect)
                    .cornerRadius(10)
                CircularProgressBar(ringWidth: r*ringWidth, color: C.Colors.lightGray, value: CGFloat( viewModel.progressBarValue))
            }
        }
    }
}

struct WaitView: View {
    @ObservedObject var viewModel: ViewModel
    var body: some View {
        GeometryReader { (geometry) in
            let r:CGFloat = min(geometry.size.width, geometry.size.height)
            ZStack{
                Circle()
                    .fill(C.Colors.bullshitRed)
                    .frame(width: r*innerRadius, height: r*innerRadius)
                    .onTapGesture {
                        viewModel.intentListenToNewQuestion()
                    }
                CircularProgressBar(ringWidth: r*ringWidth, color: C.Colors.lightGray, value: 1.0)
            }
        }
    }
}

struct AnalyseView: View {
    @ObservedObject var viewModel: ViewModel
    var body: some View {
        GeometryReader { (geometry) in
            let r:CGFloat = min(geometry.size.width, geometry.size.height)
            ZStack{
                CircularProgressBar(ringWidth: r, color: C.Colors.green, value: 1.0)
            }
        }
    }
}

struct ShowView: View {
    var body: some View {
        Circle()
    }
}

class LoadingTimer {

    let publisher = Timer.publish(every: 0.025, on: .main, in: .default)
    private var timerCancellable: Cancellable?

    func start() {
        self.timerCancellable = publisher.connect()
    }

    func cancel() {
        self.timerCancellable?.cancel()
    }
}

struct RecordButton: View {
    @ObservedObject var viewModel: ViewModel
    @State var index = 0
    
    let images = (0...105).map {
        UIImage(named: String(format: "x%03i.png", $0))!
    }
    var timer = LoadingTimer()

    var body: some View {
        return Image(uiImage: images[index])
            .onReceive(
                timer.publisher,
                perform: { _ in
                    self.index = self.index + 1
                    if self.index > 105 { self.index = 0 }
                }
            )
            .onAppear { self.timer.start() }
            .onDisappear { self.timer.cancel() }
    }
    
//    var body: some View {
//        HStack {
//            if viewModel.animatedImage != nil {
//                Image(uiImage: viewModel.animatedImage!)
//            } else {
//                Image(uiImage: UIImage(imageLiteralResourceName: "infinity.gif"))
//            }
//                
//    //            Spacer()
//    //            Text(viewModel.currentState())
//    //            Spacer()
//    //            switch(viewModel.model.value) {
//    //            case .wait:
//    //                WaitView(viewModel: viewModel)
//    //            case .listen:
//    //                ListenView(viewModel: viewModel)
//    //            case .analyse:
//    //                AnalyseView(viewModel: viewModel)
//    //            case .show:
//    //                ShowView()
//    //            }
//    //            Spacer()
//        }
//    }
}


struct RecordButton_Previews : PreviewProvider {

    static var previews: some View {
        VStack {
            RecordButton(viewModel: ViewModel())
//            RecordButton(viewModel: ViewModel(.wait))
//            RecordButton(viewModel: ViewModel(.listen))
//            RecordButton(viewModel: ViewModel(.analyse))
//            RecordButton(viewModel: ViewModel(.show))
        }
    }
}
