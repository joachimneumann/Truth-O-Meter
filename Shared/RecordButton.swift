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
    @ObservedObject var truthViewModel: ViewModel
    var body: some View {
        GeometryReader { (geometry) in
            let r:CGFloat = min(geometry.size.width, geometry.size.height)
            ZStack{
                Circle()
                    .fill(C.Colors.bullshitRed)
                    .frame(width: r*innerRadius, height: r*innerRadius)
                    .onTapGesture {
                        truthViewModel.setState(.listen)
                    }
                CircularProgressBar(ringWidth: r*ringWidth, color: C.Colors.lightGray, value: 1.0)
            }
        }
    }
}

struct ListenView: View {
    @ObservedObject var truthViewModel: ViewModel
    var body: some View {
        GeometryReader { (geometry) in
            let r:CGFloat = min(geometry.size.width, geometry.size.height)
            ZStack{
                Rectangle()
                    .foregroundColor(C.Colors.bullshitRed)
                    .frame(width: r*innerRect, height: r*innerRect)
                    .cornerRadius(10)
                CircularProgressBar(ringWidth: r*ringWidth, color: C.Colors.lightGray, value:  1.0)
                CircularProgressBar(ringWidth: r*ringWidth, color: C.Colors.bullshitRed, value:  truthViewModel.listenProgress)
            }
        }
    }
}



struct AnalyseView: View {
    @ObservedObject var truthViewModel: ViewModel
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
    @ObservedObject var truthViewModel: ViewModel
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
    @ObservedObject var truthViewModel: ViewModel
    var body: some View {
        HStack {
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
        }
        .padding()
    }
}


struct RecordButton_Previews : PreviewProvider {
    static var previews: some View {
        VStack {
            let truthViewModel = ViewModel()
            VStack {
                ModelDebugView(truthViewModel: truthViewModel)
                RecordButton(truthViewModel: truthViewModel)
            }
        }
    }
}
