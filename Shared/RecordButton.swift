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

struct WaitView: View {
    @ObservedObject var truthViewModel: TruthViewModel
    var body: some View {
        GeometryReader { (geometry) in
            let r:CGFloat = min(geometry.size.width, geometry.size.height)
            ZStack{
                Circle()
                    .fill(C.Colors.bullshitRed)
                    .frame(width: r*innerRadius, height: r*innerRadius)
                    .onTapGesture {
                        truthViewModel.intentListenToNewQuestion()
                    }
                CircularProgressBar(ringWidth: r*ringWidth, color: C.Colors.lightGray, value: 1.0)
            }
        }
    }
}

struct ListenView: View {
    @ObservedObject var truthViewModel: TruthViewModel
    var body: some View {
        GeometryReader { (geometry) in
            let r:CGFloat = min(geometry.size.width, geometry.size.height)
            ZStack{
                Rectangle()
                    .foregroundColor(C.Colors.bullshitRed)
                    .frame(width: r*innerRect, height: r*innerRect)
                    .cornerRadius(10)
                CircularProgressBar(ringWidth: r*ringWidth, color: C.Colors.lightGray, value:  truthViewModel.recordButtonValue)
            }
        }
    }
}



struct AnalyseView: View {
    @ObservedObject var truthViewModel: TruthViewModel
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
    @ObservedObject var truthViewModel: TruthViewModel
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
    @ObservedObject var truthViewModel: TruthViewModel
    var body: some View {
        HStack {
            Spacer()
//            Text(viewModel.currentState())
            Spacer()
            switch(truthViewModel.state) {
            case .wait:
                WaitView(truthViewModel: truthViewModel)
            case .listen:
                ListenView(truthViewModel: truthViewModel)
            case .analyse:
                ThinkingGif()
            case .show:
                WaitView(truthViewModel: truthViewModel)
            }
            Spacer()
        }
    }
}


struct RecordButton_Previews : PreviewProvider {
    static var previews: some View {
        VStack {
            let truthViewModel = TruthViewModel()
            VStack {
                ModelDebugView(truthViewModel: truthViewModel)
                RecordButton(truthViewModel: truthViewModel)
            }
        }
    }
}
