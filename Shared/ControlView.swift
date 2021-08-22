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
    @ObservedObject var viewModel: ViewModel
    var body: some View {
        GeometryReader { (geometry) in
            let r:CGFloat = min(geometry.size.width, geometry.size.height)
            let circleRadius = r*innerRadius*0.5
            ZStack{
                Circle()
                    .fill(C.Colors.bullshitRed)
                    .frame(width: circleRadius*2, height: circleRadius*2)
                    .onClickGesture { point in
                        let distanceFromCenter = sqrt(
                            (point.x - circleRadius) * (point.x - circleRadius) +
                            (point.y - circleRadius) * (point.y - circleRadius) ) / (circleRadius)
                        viewModel.setTruthDynamic(Double(distanceFromCenter))
                        viewModel.setState(.listen)
                    }
                CircularProgressBar(ringWidth: r*ringWidth, color: C.Colors.lightGray, value: 1.0)
            }
        }
    }
}

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
                CircularProgressBar(ringWidth: r*ringWidth, color: C.Colors.bullshitRed, value:  viewModel.listeningProgress)
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
                ThinkingGif(viewModel: viewModel)
                    .background(Color.green)
                    .frame(width: r, height: r/2, alignment: .center)
                HorizontalProgressBar(color: C.Colors.bullshitRed, value:  viewModel.analyseProgress)
                    .frame(width: r, height: 6, alignment: .center)
                    .padding(.top, r/2+20)
            }
        }
    }
}

struct ShowView: View {
    @ObservedObject var viewModel: ViewModel
    var body: some View {
        GeometryReader { (geometry) in
            VStack {
                Stamp(texts: viewModel.stampTexts)
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            viewModel.setState(.wait)
        }
    }
}


struct ControlView: View {
    @ObservedObject var viewModel: ViewModel
    var body: some View {
        HStack {
            switch(viewModel.state) {
            case .wait:
                WaitView(viewModel: viewModel)
            case .listen:
                ListenView(viewModel: viewModel)
            case .analyse:
                AnalyseView(viewModel: viewModel)
            case .show:
                ShowView(viewModel: viewModel)
            }
        }
        .padding(60)
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
                .aspectRatio(1.0, contentMode: .fit)
//                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
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
