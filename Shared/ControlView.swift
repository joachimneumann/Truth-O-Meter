//
//  RecordButton.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 14/11/2020.
//


import SwiftUI
import Combine

let innerRadius:CGFloat = 0.88
let innerRect:CGFloat = 0.4

struct WaitView: View {
    @ObservedObject var viewModel: ViewModel
    var body: some View {
        GeometryReader { (geo) in
            let circleRadius:CGFloat = geo.size.height / 2
            RecordButton(viewModel: viewModel)
                .onClickGesture { point in
                    let distanceFromCenter = sqrt(
                        (point.x - circleRadius) * (point.x - circleRadius) +
                        (point.y - circleRadius) * (point.y - circleRadius) ) / (circleRadius)
                    viewModel.setTruthDynamic(Double(distanceFromCenter))
                    withAnimation {
                        viewModel.setState(.listen)
                    }
                }
        }
    }
}

struct ListenView: View {
    @ObservedObject var viewModel: ViewModel
    var body: some View {
        RecordButton(viewModel: viewModel)
    }
}

struct AnalyseView: View {
    @ObservedObject var viewModel: ViewModel
    var body: some View {
        VStack {
            Spacer()
            ThinkingGif(viewModel: viewModel)
                .aspectRatio(2.0, contentMode: .fit)
            HorizontalProgressBar(value:  viewModel.analyseProgress)
            Text("Analysing...")
                .font(.headline)
            Spacer()
        }
        .aspectRatio(1.0, contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
        .padding()
    }
}

struct ShowView: View {
    @ObservedObject var viewModel: ViewModel
    var body: some View {
        VStack {
            Spacer()
            Stamp(texts: viewModel.stampTexts)
                .onTapGesture {
                    withAnimation {
                        viewModel.setState(.wait)
                    }
                }
            Spacer()
        }
        .aspectRatio(1.0, contentMode: .fill)
    }
}


struct ControlView: View {
    @ObservedObject var viewModel: ViewModel
    var body: some View {
        GeometryReader { (geo) in
            ZStack {
                switch(viewModel.state) {
                case .wait:
                    WaitView(viewModel: viewModel)
                        .padding(geo.size.width * 0.25)
                case .listen:
                    ListenView(viewModel: viewModel)
                        .padding(geo.size.width * 0.25)
                case .analyse:
                    AnalyseView(viewModel: viewModel)
                        .padding(geo.size.width * 0.1)
                case .show:
                    ShowView(viewModel: viewModel)
                        .padding(geo.size.width * 0.0)
                }
            }
            .aspectRatio(contentMode: .fit)
        }
    }
}


struct RecordButton_Previews : PreviewProvider {
    static var previews: some View {
        let viewModel = ViewModel()
        viewModel.setState(.show)
        return VStack {
            Spacer()
            ModelDebugView(viewModel: viewModel)
            Spacer()
            ControlView(viewModel: viewModel)
            Spacer()
        }
    }
}

struct ClickGesture: Gesture {
    let count: Int
    let coordinateSpace: CoordinateSpace
    
    typealias Value = SimultaneousGesture<TapGesture, DragGesture>.Value
    
    init(count: Int = 1, coordinateSpace: CoordinateSpace = .local) {
        precondition(count > 0, "Count must be greater than or equal to 1.")
        self.count = count
        self.coordinateSpace = coordinateSpace
    }
    
    var body: SimultaneousGesture<TapGesture, DragGesture> {
        SimultaneousGesture(
            TapGesture(count: count),
            DragGesture(minimumDistance: 0, coordinateSpace: coordinateSpace)
        )
    }
    
    func onEnded(perform action: @escaping (CGPoint) -> Void) -> _EndedGesture<ClickGesture> {
        self.onEnded { (value: Value) -> Void in
            guard value.first != nil else { return }
            guard let location = value.second?.startLocation else { return }
            guard let endLocation = value.second?.location else { return }
            guard ((location.x-1)...(location.x+1)).contains(endLocation.x),
                  ((location.y-1)...(location.y+1)).contains(endLocation.y) else {
                return
            }
            action(location)
        }
    }
}

extension View {
    func onClickGesture(
        count: Int,
        coordinateSpace: CoordinateSpace = .local,
        perform action: @escaping (CGPoint) -> Void
    ) -> some View {
        gesture(ClickGesture(count: count, coordinateSpace: coordinateSpace)
            .onEnded(perform: action)
        )
    }
    
    func onClickGesture(
        count: Int,
        perform action: @escaping (CGPoint) -> Void
    ) -> some View {
        onClickGesture(count: count, coordinateSpace: .local, perform: action)
    }
    
    func onClickGesture(
        perform action: @escaping (CGPoint) -> Void
    ) -> some View {
        onClickGesture(count: 1, coordinateSpace: .local, perform: action)
    }
}
